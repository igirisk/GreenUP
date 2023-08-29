class Post {
  String id;
  String username;
  String date;
  String challengeName;
  String caption;

  Post({
    required this.id,
    required this.username,
    required this.date,
    required this.challengeName,
    required this.caption,
  });

  Post.fromMap(this.id, Map<String, dynamic> snapshot)
      : username = snapshot['username'] ?? '',
        date = snapshot['date'] ?? '',
        challengeName = snapshot['challengeName'] ?? '',
        caption = snapshot['caption'] ?? '';
}
