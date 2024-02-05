import 'package:flutter/material.dart';

import '../../../../domain/entities/company.dart';

class CompanyTile extends StatelessWidget {
  const CompanyTile({
    super.key,
    required this.company,
    required this.onDelete,
  });
  final Company company;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(company.name),
      subtitle: Text('ID: ${company.id}'),
      trailing: IconButton(
        onPressed: onDelete,
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
