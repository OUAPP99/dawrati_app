class Cycle {
  final int id;
  final DateTime dateDebutRegles;
  final DateTime? dateFinRegles;

  Cycle({
    required this.id,
    required this.dateDebutRegles,
    this.dateFinRegles,
  });
}