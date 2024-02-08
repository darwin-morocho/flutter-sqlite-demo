class Employee {
  Employee({
    required this.id,
    required this.name,
    required this.jobTitle,
    required this.salaryInUSD,
    required this.companyId,
  });

  final int id;
  final String name;
  final String jobTitle;
  final double salaryInUSD;
  final int companyId;
}
