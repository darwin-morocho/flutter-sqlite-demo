import 'package:flutter/material.dart';

import '../../../domain/entities/company.dart';
import 'widgets/company_tile.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  List<Company>? _companies;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {}

  Future<void> _insertOne() async {}

  Future<void> _insertMany() async {}

  Future<void> _deleteOne(int id) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _insertMany,
            icon: const Icon(Icons.apps),
          ),
          IconButton(
            onPressed: _insertOne,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: _companies != null
            ? ListView.separated(
                itemBuilder: (_, index) {
                  final company = _companies![index];
                  return CompanyTile(
                    company: company,
                    onDelete: () {},
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: _companies!.length,
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
