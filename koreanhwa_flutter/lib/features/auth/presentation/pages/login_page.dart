import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:koreanhwa_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:koreanhwa_flutter/shared/widgets/app_button.dart';
import 'package:koreanhwa_flutter/shared/widgets/custom_button.dart';
import 'package:koreanhwa_flutter/shared/widgets/custom_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;
  bool _rememberMe = false;
  bool _submitting = false;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^\S+@\S+\.\S+');
    if (!emailRegex.hasMatch(value)) return 'Please enter a valid email address';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  Future<void> _onSubmit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    final notifier = ref.read(authProvider.notifier);
    await notifier.login(_emailController.text.trim(), _passwordController.text);
    final status = ref.read(authProvider);
    if (status.status == AuthState.authenticated) {
      if (!mounted) return;
      context.go('/');
    } else if (status.status == AuthState.error) {
      if (!mounted) return;
      final msg = status.errorMessage ?? 'Đăng nhập thất bại';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image + overlay (akin to Tailwind bg-cover + overlay)
          Positioned.fill(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/login_bg.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(color: Colors.white.withOpacity(0.5)),
                ),
              ],
            ),
          ),

          // Content
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 24,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    color: Colors.white.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Title
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                children: [
                                  Text('Welcome back!', style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800)),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Sign in to continue your Korean learning journey',
                                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black.withOpacity(0.7)),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),

                            // Email
                            CustomTextField(
                              label: 'Email Address',
                              hintText: 'Enter your email address',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(Icons.mail_outline),
                              onChanged: (_) => _formKey.currentState?.validate(),
                              errorText: null,
                            ),
                            const SizedBox(height: 16),

                            // Password
                            CustomTextField(
                              label: 'Password',
                              hintText: 'Enter your password',
                              controller: _passwordController,
                              obscureText: !_showPassword,
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed: () => setState(() => _showPassword = !_showPassword),
                                icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                              ),
                              onChanged: (_) => _formKey.currentState?.validate(),
                              errorText: null,
                            ),

                            const SizedBox(height: 12),
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runSpacing: 8,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      value: _rememberMe,
                                      onChanged: (v) => setState(() => _rememberMe = v ?? false),
                                    ),
                                    const SizedBox(width: 6),
                                    const Text('Remember me'),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('Forgot password?'),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),
                            CustomButton(
                              label: 'Sign In',
                              isLoading: ref.watch(authProvider).status == AuthState.loading,
                              onPressed: _onSubmit,
                              size: AppButtonSize.lg,
                            ),

                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?", style: theme.textTheme.bodyMedium),
                                TextButton(
                                  onPressed: () => context.go('/register'),
                                  child: const Text('Sign up'),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),
                            Center(
                              child: Text('Quick Demo', style: theme.textTheme.labelLarge?.copyWith(color: Colors.black54, fontWeight: FontWeight.w700)),
                            ),
                            const SizedBox(height: 12),
                            Center(
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                alignment: WrapAlignment.center,
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(minWidth: 120, maxWidth: 160),
                                    child: CustomButton(
                                      label: 'Demo Student',
                                      variant: AppButtonVariant.outline,
                                      onPressed: () {},
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(minWidth: 120, maxWidth: 160),
                                    child: CustomButton(
                                      label: 'Demo Teacher',
                                      variant: AppButtonVariant.outline,
                                      onPressed: () {},
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(minWidth: 120, maxWidth: 160),
                                    child: CustomButton(
                                      label: 'Demo Admin',
                                      variant: AppButtonVariant.outline,
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            )
                            ,
                            const SizedBox(height: 16),
                            Center(
                              child: Text('Or continue with', style: theme.textTheme.labelLarge?.copyWith(color: Colors.black54, fontWeight: FontWeight.w700)),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.g_mobiledata),
                                    label: const Text(
                                      'Google',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.facebook),
                                    label: const Text(
                                      'Facebook',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
