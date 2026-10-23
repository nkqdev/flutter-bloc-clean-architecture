import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/l10n/app_localizations.dart';
import 'package:flutter_bloc_clean_architecture/presentation/extensions/failure_extension.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_bloc_clean_architecture/presentation/widgets/buttons/primary_button.dart';
import 'package:flutter_bloc_clean_architecture/presentation/widgets/snack_bar/app_snack_bar.dart';
import 'package:flutter_bloc_clean_architecture/presentation/widgets/text_field/app_text_field.dart';
import 'package:flutter_bloc_clean_architecture/routes/app_route_names.dart';
import 'package:flutter_bloc_clean_architecture/common/theme/global_styles/index.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure && state.failure != null) {
          AppSnackBar.showError(context, state.failure!.localize(l10n));
        }
        if (state.status.isSuccess && state.isAuthenticated) {
          Navigator.of(context).pushReplacementNamed(AppRouteNames.home);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsetStyles.scaffold,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.loginTitle, style: context.textStyles.h2),
                  SizedBoxStyles.verticalSmall,
                  Text(l10n.loginSubtitle),
                  SizedBoxStyles.verticalHuge,
                  AppTextField(
                    label: l10n.username,
                    prefixIcon: const Icon(Icons.person_outline),
                    textInputAction: TextInputAction.next,
                    onChanged: (value) =>
                        authBloc.add(AuthEvent.usernameChanged(value)),
                  ),
                  SizedBoxStyles.verticalMedium,
                  AppTextField(
                    label: l10n.password,
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                    textInputAction: TextInputAction.done,
                    onChanged: (value) =>
                        authBloc.add(AuthEvent.passwordChanged(value)),
                    onSubmitted: (_) => authBloc.add(const AuthEvent.login()),
                  ),
                  SizedBoxStyles.verticalHuge,
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) => PrimaryButton(
                      label: l10n.login,
                      isLoading: state.status.isLoading,
                      onPressed: state.isValidInput
                          ? () => authBloc.add(const AuthEvent.login())
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
