class Note {
  final String userId;
  final String title;
  final String content;
  final String dateTime;
  Note({this.userId, this.title, this.dateTime, this.content});

  factory Note.fromMap(Map<String, dynamic> map, String documentID) {
    return Note(
        userId: documentID,
        title: map['title'],
        dateTime: map['dateTime'] ?? '',
        content: map['content']);
  }
  Map<String, dynamic> toMap() {
    return {'title': title, 'content': content, 'dateTime': dateTime};
  }
}
