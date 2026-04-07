import 'package:flutter/material.dart';
import 'package:ojas_user/core/widgets/ojas_layout.dart';

class ShellScreen extends StatelessWidget {
  final Widget child;
  const ShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return OjasLayout(child: child);
  }
}

