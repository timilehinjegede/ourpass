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
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at']),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'is_verified': isVerified,
        if (createdAt != null)
          'created_at': createdAt?.millisecondsSinceEpoch.toString(),
        if (updatedAt != null)
          'updated_at': updatedAt?.millisecondsSinceEpoch.toString(),
      };
}
