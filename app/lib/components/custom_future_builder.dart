import 'package:app/components/error_widget.dart';
import 'package:app/components/loading_widget.dart';
import 'package:flutter/material.dart';

class CustomFutureBuilder<T> extends StatelessWidget {
  final Widget Function(BuildContext, T?) builder;
  final Future<T> future;
  const CustomFutureBuilder(
      {super.key, required this.builder, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (state.hasError) {
            return MyErrorWidget(error: state.error);
          }
          return builder(context, state.data);
        });
  }
}
