class UserModel {
  final String name;
  final String email;
  final String photourl;
  final String role;

  UserModel({
    required this.name,
    required this.email,
    required this.photourl,
    required this.role,
  });


  Map<String, dynamic> toJson() => {
    'name' : name,
    'email' : email,
    'photourl' : photourl,
    'role' : role,
  };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        photourl: json['photourl'],
        role: json['role'],
      );
}
