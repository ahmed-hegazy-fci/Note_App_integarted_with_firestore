class NoteModel {
  final String title;
  final String description;
  final DateTime date;
  NoteModel({
    required this.date,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      date: DateTime.tryParse(map['date']?.toString() ?? '') ?? DateTime.now(),
      title: (map['title'] ?? '').toString(),
      description: (map['description'] ?? '').toString(),
    );
  }
}
