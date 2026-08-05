import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_controller.dart';
import '../../l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool? _createMode;
  bool _rememberMe = true;
  bool _obscurePassword = true;
  bool _submitting = false;
  String? _error;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _createMode ??= !context.read<AppController>().hasLocalAccount;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _submitting = true;
      _error = null;
    });

    final controller = context.read<AppController>();
    final creating = _createMode ?? false;
    final success = creating
        ? await controller.createAccount(
            fullName: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            rememberMe: _rememberMe,
          )
        : await controller.signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            rememberMe: _rememberMe,
          );

    if (!mounted) return;
    setState(() {
      _submitting = false;
      if (!success) _error = _AuthWords.of(context).failed(creating);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final words = _AuthWords.of(context);
    final controller = context.watch<AppController>();
    final creating = _createMode ?? !controller.hasLocalAccount;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 850;
            final form = _buildForm(context, l, words, controller, creating);
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1080),
                  child: Card(
                    elevation: 14,
                    clipBehavior: Clip.antiAlias,
                    child: wide
                        ? Row(children: [
                            Expanded(child: _WelcomePanel(l: l)),
                            Expanded(child: form),
                          ])
                        : Column(children: [
                            _WelcomePanel(l: l, compact: true),
                            form,
                          ]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    AppLocalizations l,
    _AuthWords words,
    AppController controller,
    bool creating,
  ) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(children: [
              Expanded(
                child: Text(
                  creating ? words.createAccount : l.signIn,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              PopupMenuButton<String>(
                tooltip: l.language,
                initialValue: controller.locale.languageCode,
                icon: const Icon(Icons.language_rounded),
                onSelected: (value) => controller.setLocale(Locale(value)),
                itemBuilder: (_) => [
                  PopupMenuItem(value: 'en', child: Text(l.english)),
                  PopupMenuItem(value: 'ne', child: Text(l.nepali)),
                  PopupMenuItem(value: 'hi', child: Text(l.hindi)),
                ],
              ),
            ]),
            const SizedBox(height: 8),
            Text(creating ? words.createSubtitle : words.loginSubtitle),
            const SizedBox(height: 24),
            if (creating) ...[
              TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: words.fullName,
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                ),
                validator: (value) => (value ?? '').trim().length < 2 ? words.nameRequired : null,
              ),
              const SizedBox(height: 16),
            ],
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: l.email,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) return l.emailRequired;
                if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text)) {
                  return l.emailInvalid;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submitting ? null : _submit(),
              decoration: InputDecoration(
                labelText: l.password,
                helperText: creating ? words.passwordRule : null,
                helperMaxLines: 2,
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                suffixIcon: IconButton(
                  tooltip: _obscurePassword ? l.showPassword : l.hidePassword,
                  onPressed: () => setState(
                    () => _obscurePassword = !_obscurePassword,
                  ),
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  ),
                ),
              ),
              validator: (value) {
                final password = value ?? '';
                if (password.isEmpty) return l.passwordRequired;
                if (creating &&
                    (password.length < 8 ||
                        !RegExp(r'[A-Z]').hasMatch(password) ||
                        !RegExp(r'[0-9]').hasMatch(password))) {
                  return words.passwordRule;
                }
                return null;
              },
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: _rememberMe,
              onChanged: (value) => setState(() => _rememberMe = value ?? false),
              title: Text(words.rememberMe),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _submitting ? null : _submit,
              icon: _submitting
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(creating ? Icons.person_add_alt_1_rounded : Icons.login_rounded),
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  _submitting
                      ? l.signingIn
                      : creating
                          ? words.createAccount
                          : l.signIn,
                ),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: _submitting
                  ? null
                  : () => setState(() {
                        _createMode = !creating;
                        _error = null;
                        _passwordController.clear();
                      }),
              child: Text(
                creating ? words.logInInstead : words.createInstead,
              ),
            ),
            const SizedBox(height: 18),
            Row(children: [
              Icon(Icons.lock_outline_rounded,
                  size: 18, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  words.localPrivacy,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class _WelcomePanel extends StatelessWidget {
  const _WelcomePanel({required this.l, this.compact = false});
  final AppLocalizations l;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: compact ? 260 : 620),
      padding: EdgeInsets.all(compact ? 28 : 44),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.tertiary,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.notifications_off_rounded, size: 42, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Text(
            l.appTitle,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            l.loginWelcome,
            style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, height: 1.45),
          ),
          if (!compact) ...[
            const SizedBox(height: 28),
            _Feature(Icons.schedule_rounded, l.loginFeatureSchedules),
            _Feature(Icons.public_rounded, l.loginFeatureClock),
            _Feature(Icons.lock_outline_rounded, l.loginFeaturePrivacy),
          ],
        ],
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  const _Feature(this.icon, this.text);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white))),
        ]),
      );
}

class _AuthWords {
  const _AuthWords(this.code);
  final String code;
  static _AuthWords of(BuildContext context) =>
      _AuthWords(Localizations.localeOf(context).languageCode);
  bool get ne => code == 'ne';
  bool get hi => code == 'hi';

  String get createAccount => ne
      ? 'खाता बनाउनुहोस्'
      : hi
          ? 'खाता बनाएँ'
          : 'Create account';
  String get createSubtitle => ne
      ? 'बैठक व्यवस्थापन सुरु गर्न आफ्नो विवरण लेख्नुहोस्।'
      : hi
          ? 'मीटिंग प्रबंधन शुरू करने के लिए अपना विवरण दर्ज करें।'
          : 'Enter your details to start managing your meetings.';
  String get loginSubtitle => ne
      ? 'आफ्नो स्थानीय खाताबाट लगइन गर्नुहोस्।'
      : hi
          ? 'अपने स्थानीय खाते से साइन इन करें।'
          : 'Sign in with your local account.';
  String get fullName => ne
      ? 'पूरा नाम'
      : hi
          ? 'पूरा नाम'
          : 'Full name';
  String get nameRequired => ne
      ? 'कृपया आफ्नो पूरा नाम लेख्नुहोस्।'
      : hi
          ? 'कृपया अपना पूरा नाम दर्ज करें।'
          : 'Enter your full name.';
  String get passwordRule => ne
      ? 'कम्तीमा ८ अक्षर, एउटा ठूलो अक्षर र एउटा अंक प्रयोग गर्नुहोस्।'
      : hi
          ? 'कम से कम 8 अक्षर, एक बड़ा अक्षर और एक संख्या उपयोग करें।'
          : 'Use at least 8 characters, one uppercase letter and one number.';
  String get rememberMe => ne
      ? 'यस उपकरणमा मलाई सम्झनुहोस्'
      : hi
          ? 'इस डिवाइस पर मुझे याद रखें'
          : 'Remember me on this device';
  String get logInInstead => ne
      ? 'बरु लगइन गर्नुहोस्'
      : hi
          ? 'इसके बजाय साइन इन करें'
          : 'Log in instead';
  String get createInstead => ne
      ? 'नयाँ खाता बनाउनुहोस्'
      : hi
          ? 'नया खाता बनाएँ'
          : 'Create a new account';
  String get localPrivacy => ne
      ? 'तपाईंको खाता र प्राथमिकताहरू यस उपकरणमा मात्र रहन्छन्।'
      : hi
          ? 'आपका खाता और प्राथमिकताएँ केवल इसी डिवाइस पर रहती हैं।'
          : 'Your account and preferences remain on this device.';
  String failed(bool creating) => ne
      ? creating
          ? 'खाता बनाउन सकिएन। विवरण जाँच्नुहोस्।'
          : 'इमेल वा पासवर्ड गलत छ।'
      : hi
          ? creating
              ? 'खाता नहीं बनाया जा सका। विवरण जाँचें।'
              : 'ईमेल या पासवर्ड गलत है।'
          : creating
              ? 'The account could not be created. Check the details.'
              : 'Incorrect email or password.';
}
