import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/l10n/app_localizations.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/status.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_list_bloc.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_list_event.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/user/user_list_state.dart';
import 'package:flutter_bloc_clean_architecture/presentation/screens/user/widgets/user_item.dart';
import 'package:flutter_bloc_clean_architecture/presentation/widgets/errors/error_view.dart';
import 'package:flutter_bloc_clean_architecture/presentation/widgets/loading/app_loading.dart';
import 'package:flutter_bloc_clean_architecture/common/theme/global_styles/index.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<UserListBloc>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.users)),
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state.status == BlocStatus.initial || state.status.isLoading) {
            return const AppLoading();
          }
          if (state.status.isFailure) {
            return ErrorView(
              failure: state.failure,
              onRetry: () => bloc.add(const UserListEvent.refresh()),
            );
          }
          if (state.users.isEmpty) {
            return Center(child: Text(l10n.emptyData));
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.extentAfter < 200) {
                bloc.add(const UserListEvent.loadMore());
              }
              return false;
            },
            child: RefreshIndicator(
              onRefresh: () async => bloc.add(const UserListEvent.refresh()),
              child: ListView.separated(
                itemCount: state.users.length + (state.isLoadingMore ? 1 : 0),
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  if (index >= state.users.length) {
                    return Padding(
                      padding: EdgeInsetStyles.allLarge,
                      child: const AppLoading(),
                    );
                  }
                  return UserItem(user: state.users[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
