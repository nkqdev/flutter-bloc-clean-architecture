import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/common/dimension/dimension.dart';

class AppLoading extends StatelessWidget {
  final double size;

  const AppLoading({super.key, this.size = Dimension.loadingSizeMedium});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: size,
        child: const CircularProgressIndicator(strokeWidth: 2.5),
      ),
    );
  }
}
