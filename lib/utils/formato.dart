// Angel Jefferson Sanchez Ventura
// Matricula:2021-1816

String formatearFecha(String iso) {
  final d = DateTime.parse(iso);
  String dos(int n) => n.toString().padLeft(2, '0');
  return '${dos(d.day)}/${dos(d.month)}/${d.year}';
}