import 'package:flutter/material.dart';

class FullScreenLoaderWidget extends StatelessWidget {
  const FullScreenLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
