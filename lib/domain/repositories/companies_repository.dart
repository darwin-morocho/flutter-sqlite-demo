import '../entities/company.dart';
import '../inputs/company_input.dart';

abstract interface class CompaniesRepository {
  Future<List<Company>> getAll();
  Future<Company?> insertOne(CompanyInput input);
  Future<bool> uptateOne(int id, CompanyInput input);
  Future<bool> deleteOne(int id);
}
