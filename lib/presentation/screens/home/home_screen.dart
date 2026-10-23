import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/common/enums/locale_enum.dart';
import 'package:flutter_bloc_clean_architecture/common/utils/app_utils.dart';
import 'package:flutter_bloc_clean_architecture/l10n/app_localizations.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/locale/locale_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/locale/locale_event.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/theme/theme_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/theme/theme_event.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_profile_cubit.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_profile_state.dart';
import 'package:flutter_bloc_clean_architecture/presentation/widgets/errors/error_view.dart';
import 'package:flutter_bloc_clean_architecture/presentation/widgets/loading/app_loading.dart';
import 'package:flutter_bloc_clean_architecture/routes/app_route_names.dart';
import 'package:flutter_bloc_clean_architecture/common/theme/global_styles/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess && !state.isAuthenticated) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(AppRouteNames.login, (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.home),
          actions: [
            IconButton(
              tooltip: l10n.logout,
              icon: const Icon(Icons.logout),
              onPressed: () =>
                  context.read<AuthBloc>().add(const AuthEvent.logout()),
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsetStyles.scaffold,
          children: [
            BlocBuilder<UserProfileCubit, UserProfileState>(
              builder: (context, state) {
                final user = state.user;
                if (state.status.isFailure) {
                  return ErrorView(
                    failure: state.failure,
                    onRetry: () => context.read<UserProfileCubit>().load(),
                  );
                }
                if (user == null) return const AppLoading();
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(user.fullName),
                  subtitle: Text(user.email ?? ''),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.people_outline),
              title: Text(l10n.users),
              trailing: const Icon(Icons.chevron_right),
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRouteNames.userList),
            ),
            SwitchListTile(
              secondary: const Icon(Icons.dark_mode_outlined),
              title: Text(l10n.darkMode),
              value: context.select((ThemeBloc bloc) => bloc.state.isDarkTheme),
              onChanged: (value) =>
                  context.read<ThemeBloc>().add(ThemeEvent.themeChanged(value)),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(l10n.language),
              trailing: DropdownButton<SupportLocale>(
                value: SupportLocale.fromCode(
                  context.select(
                    (LocaleBloc bloc) => bloc.state.locale.languageCode,
                  ),
                ),
                underline: const SizedBox.shrink(),
                items: SupportLocale.values
                    .map(
                      (e) => DropdownMenuItem(value: e, child: Text(e.label)),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  context.read<LocaleBloc>().add(
                    LocaleEvent.localeChanged(Locale(value.name)),
                  );
                },
              ),
            ),
            SizedBoxStyles.verticalLarge,
            Center(child: Text('${l10n.version} ${AppUtils.version}')),
          ],
        ),
      ),
    );
  }
}
