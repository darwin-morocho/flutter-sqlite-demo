import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';

import '../../models/company.dart';
import '../../services/db_service.dart';
import 'widgets/company_tile.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  List<Company>? _companies;
  final _dbService = DbService();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _dbService.close();
    super.dispose();
  }

  Future<void> _load() async {
    await _dbService.open(dbName: 'my_db.sqlite', version: 1);
    final results = await _dbService.rawQuery('SELECT * FROM company');
    if (results != null) {
      _companies = results
          .map(
            (json) => Company(
              id: json['id'],
              name: json['name'],
            ),
          )
          .toList();
    } else {
      _companies = [];
    }

    setState(() {});
  }

  Future<void> _insertOne() async {
    final name = faker.faker.company.name();
    // INSERT INTO company(name) VALUES (Shanahan, Kulas and Grady)
    // final id = await _dbService.rawInsert(
    //   'INSERT INTO company(name) VALUES (?)',
    //   arguments: [name],
    // );
    final id = await _dbService.insert(
      'company',
      {
        'name': name,
      },
    );
    if (id == null) {
      return;
    }
    setState(() {
      _companies!.add(
        Company(id: id, name: name),
      );
    });
  }

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
