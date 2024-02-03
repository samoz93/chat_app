import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final Object? error;
  const MyErrorWidget({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Text(error?.toString() ?? "Error");
  }
}
