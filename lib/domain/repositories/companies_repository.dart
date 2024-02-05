import '../entities/company.dart';

abstract interface class CompaniesRepository {
  Future<List<Company>> getAll();
  Future<Company?> insert({
    required String name,
    required String description,
  });
  Future<List<Company>?> insertAll(
    List<({String name, String description})> items,
  );
  Future<bool> delete(int id);
}
