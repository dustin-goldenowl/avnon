import 'package:flutter/material.dart';
import 'package:flutter_form_google/src/data/models/form.dart';

class CreateResponsePage extends StatelessWidget {
  const CreateResponsePage({super.key, required this.item});
  static const routeName = '/create-response';
  final MFormData item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Response'),
      ),
    );
  }
}
