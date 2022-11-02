class Comment {
  final String name, email, body;

  const Comment({
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}
