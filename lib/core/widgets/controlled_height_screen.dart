import 'package:flutter/material.dart';

class ControlledHeightScreen extends StatelessWidget {
  final EdgeInsets padding;
  final Widget child;

  const ControlledHeightScreen({super.key, required this.padding, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: Padding(padding: padding, child: child),
          ),
        ),
      ),
    );
  }
}
