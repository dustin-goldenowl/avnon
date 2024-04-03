import 'package:flutter/material.dart';
import 'package:flutter_form_google/src/route/coordinator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              AppCoordinator.showCreateForm(context);
            },
            child: const Text('Add Form'),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              AppCoordinator.showResponse(context);
            },
            child: const Text('Show Form Response'),
          ),
        ],
      ),
    );
  }
}
