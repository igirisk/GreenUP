class Profile {
  String id;
  String username;
  String pfp;
  String email;

  Profile({
    required this.id,
    required this.username,
    required this.pfp,
    required this.email,
  });

  Profile.fromMap(this.id, Map<String, dynamic> snapshot)
      : username = snapshot['username'] ?? '',
        pfp = snapshot['pfp'] ?? '',
        email = snapshot['email'] ?? '';
}
