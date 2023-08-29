class Tree {
  String id;
  String username;
  String date;
  String status;
  String treeImage;

  Tree({
    required this.id,
    required this.username,
    required this.date,
    required this.status,
    required this.treeImage,
  });

  Tree.fromMap(this.id, Map<String, dynamic> snapshot)
      : username = snapshot['username'] ?? '',
        date = snapshot['date'] ?? '',
        status = snapshot['status'] ?? '',
        treeImage = snapshot['treeImage'] ?? '';
}
