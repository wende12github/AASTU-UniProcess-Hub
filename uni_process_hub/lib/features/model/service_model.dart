class ServiceModels {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String hours;
  final String avgService;
  final int peopleInLine;
  final String waitTime;
  final String badge;
  final bool disabled;

  bool expanded;

  ServiceModels({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.hours,
    required this.avgService,
    required this.peopleInLine,
    required this.waitTime,
    required this.badge,
    this.expanded = false,
    this.disabled = false,
  });
}
