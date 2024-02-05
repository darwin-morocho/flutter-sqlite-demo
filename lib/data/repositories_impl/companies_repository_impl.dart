import '../../domain/entities/company.dart';
import '../../domain/inputs/company_input.dart';
import '../../domain/repositories/companies_repository.dart';

class CompaniesRepositoryImpl implements CompaniesRepository {
  @override
  Future<bool> deleteOne(int id) {
    // TODO: implement deleteOne
    throw UnimplementedError();
  }

  @override
  Future<List<Company>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Company?> insertOne(CompanyInput input) {
    // TODO: implement insertOne
    throw UnimplementedError();
  }

  @override
  Future<bool> uptateOne(int id, CompanyInput input) {
    // TODO: implement uptateOne
    throw UnimplementedError();
  }
}
