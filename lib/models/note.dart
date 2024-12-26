class Note {
  final String recordId;
  final String content;
  final String author;

  Note({required this.recordId, required this.content, required this.author});

  Map<String, dynamic> toMap() {
    return {'content': content, 'author': author};
  }
}
