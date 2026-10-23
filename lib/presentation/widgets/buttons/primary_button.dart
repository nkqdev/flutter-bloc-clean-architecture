import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/common/dimension/dimension.dart';
import 'package:flutter_bloc_clean_architecture/common/dimension/app_scale.dart';
import 'package:flutter_bloc_clean_architecture/presentation/widgets/loading/app_loading.dart';
import 'package:flutter_bloc_clean_architecture/common/theme/global_styles/index.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppScale.h(Dimension.buttonHeight),
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: RadiusStyles.mediumBorder,
          ),
        ),
        child: isLoading
            ? const AppLoading(size: Dimension.loadingSizeSmall)
            : Text(label),
      ),
    );
  }
}
