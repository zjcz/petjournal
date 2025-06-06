import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String? labelText;

  const LoadingWidget({super.key, this.labelText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 50,
        children: [
          CircularProgressIndicator(),
          Text(labelText ?? 'Loading...'),
        ],
      ),
    );
  }
}
