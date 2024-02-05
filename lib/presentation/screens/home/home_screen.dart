import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entities/company.dart';
import '../../../domain/repositories/companies_repository.dart';
import 'widgets/company_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Company>? _companies;

  @override
  void initState() {
    super.initState();
    _loadCompanies();
  }

  Future<void> _loadCompanies() async {
    _companies = await GetIt.instance.get<CompaniesRepository>().getAll();
    setState(() {});
  }

  Future<void> _insertCompany() async {
    final company = await GetIt.instance.get<CompaniesRepository>().insert(
          name: faker.faker.company.name(),
          description: faker.faker.company.position(),
        );
    if (company == null) {
      return;
    }
    setState(() {
      _companies!.add(company);
    });
  }

  Future<void> _insertMany() async {
    final companies = await GetIt.instance.get<CompaniesRepository>().insertAll(
      [
        (
          name: faker.faker.company.name(),
          description: faker.faker.company.position(),
        ),
        (
          name: faker.faker.company.name(),
          description: faker.faker.company.position(),
        ),
      ],
    );
    if (companies == null) {
      return;
    }
    setState(() {
      _companies!.addAll(companies);
    });
  }

  Future<void> _deleteCompany(int id) async {
    final deleted = await GetIt.instance.get<CompaniesRepository>().delete(id);

    if (deleted) {
      final index = _companies!.indexWhere((e) => e.id == id);
      if (index == -1) {
        return;
      }
      setState(() {
        _companies!.removeAt(index);
      });
    }
  }

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
            onPressed: _insertCompany,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: _companies != null
            ? ListView.separated(
                itemBuilder: (_, index) => CompanyTile(
                  company: _companies![index],
                  onDelete: () => _deleteCompany(_companies![index].id),
                ),
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
