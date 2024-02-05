import '../../domain/entities/company.dart';
import '../../domain/repositories/companies_repository.dart';
import '../services/local/database_service.dart';

class CompaniesRepositoryImpl implements CompaniesRepository {
  CompaniesRepositoryImpl(this._databaseService);

  final DatabaseService _databaseService;

  @override
  Future<List<Company>> getAll() async {
    final data = await _databaseService.rawQuery('SELECT * FROM company');
    return data
        .map(
          (json) => Company(
            id: json['id'],
            name: json['name'],
            description: json['description'],
          ),
        )
        .toList();
  }

  @override
  Future<Company?> insert({
    required String name,
    required String description,
  }) async {
    final id = await _databaseService.rawInsert(
      'INSERT INTO Company(name,description) values(?,?)',
      arguments: [name, description],
    );
    if (id == null) {
      return null;
    }
    return Company(id: id, name: name, description: description);
  }

  @override
  Future<bool> delete(int id) {
    return _databaseService.rawDelete('DELETE FROM company WHERE id = $id');
  }

  @override
  Future<List<Company>?> insertAll(
    List<({String description, String name})> items,
  ) {
    return _databaseService.insertAll(
      'company',
      [
        ...items.map(
          (e) => InsertRecord(
            {
              'name': e.name,
              'description': e.description,
            },
            (id) => Company(
              id: id,
              name: e.name,
              description: e.description,
            ),
          ),
        ),
      ],
    );
  }
}
