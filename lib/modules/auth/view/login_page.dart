import 'package:flutter/material.dart';
import 'package:todo_gabarito/modules/todos/presenter/todos_page.dart';

import '../viewmodel/login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final colorScheme = Theme.of(context).colorScheme;
        final error = widget.viewModel.error;
        return Scaffold(
          backgroundColor: const Color(0xFFF6F7FB),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: AutofillGroup(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Icon(
                              Icons.checklist_rounded,
                              color: colorScheme.onPrimary,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 29,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.8,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Acesse suas tarefas, hábitos e notas.',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 28),
                        TextField(
                          onChanged: widget.viewModel.setEmail,
                          enabled: !widget.viewModel.loading,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autocorrect: false,
                          autofillHints: const [AutofillHints.email],
                          decoration: _decoration(
                            label: 'E-mail',
                            icon: Icons.mail_outline_rounded,
                            errorText: widget.viewModel.emailError,
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextField(
                          onChanged: widget.viewModel.setPassword,
                          onSubmitted: (_) => widget.viewModel.login(),
                          enabled: !widget.viewModel.loading,
                          obscureText: widget.viewModel.obscurePassword,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.password],
                          decoration: _decoration(
                            label: 'Senha',
                            icon: Icons.lock_outline_rounded,
                            suffix: IconButton(
                              tooltip: widget.viewModel.obscurePassword
                                  ? 'Mostrar senha'
                                  : 'Esconder senha',
                              onPressed: widget.viewModel.togglePasswordVisibility,
                              icon: Icon(
                                widget.viewModel.obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        CheckboxListTile(
                          value: widget.viewModel.rememberMe,
                          onChanged: widget.viewModel.loading
                              ? null
                              : (_) => widget.viewModel.toggleRememberMe(),
                          title: const Text('Lembrar de mim'),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        if (error != null) ...[
                          const SizedBox(height: 10),
                          _ErrorBanner(message: error),
                        ],
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 52,
                          child: FilledButton(
                            onPressed:
                                widget.viewModel.canSubmit ? widget.viewModel.login : null,
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            child: widget.viewModel.loading
                                ? const SizedBox.square(
                                    dimension: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : const Text('Entrar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  InputDecoration _decoration({
    required String label,
    required IconData icon,
    String? errorText,
    Widget? suffix,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFFE6E6EA)),
    );
    return InputDecoration(
      labelText: label,
      errorText: errorText,
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      border: border,
      enabledBorder: border,
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, color: colorScheme.error),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: colorScheme.onErrorContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
