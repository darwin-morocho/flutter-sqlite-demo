import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'data/repositories_impl/companies_repository_impl.dart';
import 'data/services/local/database_service.dart';
import 'domain/repositories/companies_repository.dart';
import 'presentation/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.registerSingleton<CompaniesRepository>(
    CompaniesRepositoryImpl(
      await DatabaseService.open('demo.sqlite', 2),
    ),
  );
  runApp(const MyApp());
}
