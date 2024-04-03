import 'package:flutter/material.dart';

class ResponsePage extends StatelessWidget {
  const ResponsePage({super.key});
  static const routeName = '/response';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Response'),
      ),
    );
  }
}
