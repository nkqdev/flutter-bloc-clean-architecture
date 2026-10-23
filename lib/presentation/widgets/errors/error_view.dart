import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/domain/failures/failure.dart';
import 'package:flutter_bloc_clean_architecture/l10n/app_localizations.dart';
import 'package:flutter_bloc_clean_architecture/presentation/extensions/failure_extension.dart';
import 'package:flutter_bloc_clean_architecture/common/theme/global_styles/index.dart';

class ErrorView extends StatelessWidget {
  final Failure? failure;
  final VoidCallback? onRetry;

  const ErrorView({super.key, this.failure, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final message = failure?.localize(l10n) ?? l10n.errorUnknown;

    return Center(
      child: Padding(
        padding: EdgeInsetStyles.allLarge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            SizedBoxStyles.verticalMedium,
            Text(message, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              SizedBoxStyles.verticalMedium,
              OutlinedButton(onPressed: onRetry, child: Text(l10n.retry)),
            ],
          ],
        ),
      ),
    );
  }
}
