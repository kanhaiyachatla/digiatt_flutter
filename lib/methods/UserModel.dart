class UserModel {
  final String name;
  final String email;
  final String photourl;

  UserModel({
    required this.name,
    required this.email,
    required this.photourl,
  });


  Map<String, dynamic> toJson() => {
    'name' : name,
    'email' : email,
    'photourl' : photourl,
  };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        photourl: json['photourl'],
      );
}
