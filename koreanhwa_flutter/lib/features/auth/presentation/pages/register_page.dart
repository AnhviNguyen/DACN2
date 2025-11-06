import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koreanhwa_flutter/shared/widgets/app_button.dart';
import 'package:koreanhwa_flutter/shared/widgets/custom_button.dart';
import 'package:koreanhwa_flutter/shared/widgets/custom_text_field.dart';
import 'package:koreanhwa_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _submitting = false;

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email là bắt buộc';
    final emailRegex = RegExp(r'^\S+@\S+\.\S+');
    if (!emailRegex.hasMatch(value.trim())) return 'Email không hợp lệ';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Mật khẩu là bắt buộc';
    if (value.length < 6) return 'Mật khẩu phải có ít nhất 6 ký tự';
    if (value.contains(' ')) return 'Mật khẩu không được chứa dấu cách';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Vui lòng nhập lại mật khẩu';
    if (value != _passwordController.text) return 'Mật khẩu không khớp';
    return null;
  }

  Future<void> _onSubmit() async {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    final notifier = ref.read(authProvider.notifier);
    await notifier.register(_emailController.text.trim(), _passwordController.text);
    final status = ref.read(authProvider);
    if (status.status == AuthState.authenticated) {
      if (!mounted) return;
      context.go('/');
    } else if (status.status == AuthState.error) {
      if (!mounted) return;
      final msg = status.errorMessage ?? 'Đăng ký thất bại';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
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
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                children: [
                                  Text(
                                    'Đăng ký và bắt đầu học',
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Hoặc đăng ký bằng email',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),

                            // Email
                            CustomTextField(
                              label: 'Email',
                              hintText: 'linh@memrise.com',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(Icons.mail_outline),
                              onChanged:
                                  (_) => _formKey.currentState?.validate(),
                              errorText: null,
                            ),
                            const SizedBox(height: 16),

                            // Password
                            CustomTextField(
                              label: 'Mật khẩu',
                              hintText: '********',
                              controller: _passwordController,
                              obscureText: !_showPassword,
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed:
                                    () => setState(
                                      () => _showPassword = !_showPassword,
                                    ),
                                icon: Icon(
                                  _showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              onChanged:
                                  (_) => _formKey.currentState?.validate(),
                              errorText: null,
                            ),

                            const SizedBox(height: 8),
                            Text(
                              'Hãy đảm bảo mật khẩu của bạn:',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text('\u2022 '),
                                      const SizedBox(width: 4),
                                      const Expanded(
                                        child: Text('có ít nhất 6 ký tự'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Text('\u2022 '),
                                      const SizedBox(width: 4),
                                      const Expanded(
                                        child: Text('không có dấu cách'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),
                            // Confirm Password
                            CustomTextField(
                              label: 'Nhập lại mật khẩu',
                              hintText: '********',
                              controller: _confirmPasswordController,
                              obscureText: !_showConfirmPassword,
                              prefixIcon: const Icon(
                                Icons.lock_person_outlined,
                              ),
                              suffixIcon: IconButton(
                                onPressed:
                                    () => setState(
                                      () =>
                                          _showConfirmPassword =
                                              !_showConfirmPassword,
                                    ),
                                icon: Icon(
                                  _showConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              onChanged:
                                  (_) => _formKey.currentState?.validate(),
                              errorText: null,
                            ),

                            const SizedBox(height: 20),
                            CustomButton(
                              label: 'Đăng ký',
                              isLoading: ref.watch(authProvider).status == AuthState.loading,
                              onPressed: _onSubmit,
                              size: AppButtonSize.lg,
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
