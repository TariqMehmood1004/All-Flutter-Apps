class NotesModel {
  String? title;
  String? description;
  String? dateTime = DateTime.now().toString();
  String? imageUrl;

  NotesModel(
  {
    required this.title,
    required this.description,
    required this.dateTime,
    required this.imageUrl,
  });

}
