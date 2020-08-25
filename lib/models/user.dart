class User {
  final userId;
  final username;
  final email;

  User({this.username, this.userId, this.email});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'userId': userId,
      'email': email,
    };
  }
}
