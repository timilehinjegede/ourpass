class UserModel {
  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  bool? isVerified;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        isVerified: json['is_verified'],
        createdAt: json['created_at'] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                int.parse(
                  json['created_at'].toString(),
                ),
              )
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                int.parse(
                  json['updated_at'].toString(),
                ),
              )
            : null,
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (firstName != null) 'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
        if (email != null) 'email': email,
        if (isVerified != null) 'is_verified': isVerified,
        if (createdAt != null) 'created_at': createdAt?.millisecondsSinceEpoch,
        if (updatedAt != null) 'updated_at': updatedAt?.millisecondsSinceEpoch,
      };
}
