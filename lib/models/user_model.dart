class UserModel {
  final name;
  final email;
  final id;
  UserModel({required this.name, required this.email, required this.id});

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "uid": id,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      id: map['uid'],
    );
  }
}
