import 'package:flutter/material.dart';

import '../../../domain/entities/company.dart';
import '../../../domain/inputs/company_input.dart';

class EditCompanyScreen extends StatefulWidget {
  const EditCompanyScreen({super.key, required this.company});
  final Company company;

  @override
  State<EditCompanyScreen> createState() => _EditCompanyScreenState();
}

class _EditCompanyScreenState extends State<EditCompanyScreen> {
  late CompanyInput _input;

  @override
  void initState() {
    super.initState();
    _input = CompanyInput(name: widget.company.name);
  }

  void save() {}

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextFormField(
                initialValue: widget.company.name,
                onChanged: (value) {
                  _input = CompanyInput(
                    name: value.trim(),
                  );
                },
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isEmpty) {
                    return 'Invalid name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
              ),
              TextFormField(
                onChanged: (value) {},
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isEmpty) {
                    return 'Invalid description';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Description'),
                ),
                minLines: 3,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
