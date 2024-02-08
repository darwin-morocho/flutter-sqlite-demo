import 'package:flutter/material.dart';

class CompanyFormScreen extends StatefulWidget {
  const CompanyFormScreen({super.key});

  @override
  State<CompanyFormScreen> createState() => _CompanyFormScreenState();
}

class _CompanyFormScreenState extends State<CompanyFormScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> save() async {}

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
                onChanged: (value) {},
                validator: (value) {
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
              ),
              TextFormField(
                onChanged: (value) {},
                validator: (value) {
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
