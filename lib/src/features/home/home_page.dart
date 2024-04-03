import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:flutter_form_google/src/features/home/logic/home_bloc.dart';
import 'package:flutter_form_google/src/localization/localization_utils.dart';
import 'package:flutter_form_google/src/route/coordinator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final state = context.read<HomeBloc>().state;
      if (state.froms.isEmpty) {
        //* Initially the app will display an empty form with an ‘Add Question’ button.
        AppCoordinator.showCreateForm(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(S.of(context).app_title)),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AppCoordinator.showCreateForm(context);
            },
            child: const Icon(Icons.add),
          ),
          body: state.froms.isEmpty
              ? _buildEmpty(context)
              : ListView.builder(
                  itemCount: state.froms.length,
                  itemBuilder: (context, index) {
                    return _buildFormItem(context, state.froms[index]);
                  },
                ),
        );
      },
    );
  }

  Widget _buildFormItem(BuildContext context, MFormData item) {
    return Text(item.title);
  }

  Center _buildEmpty(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Text(S.of(context).home_list_empty),
      ),
    );
  }
}
