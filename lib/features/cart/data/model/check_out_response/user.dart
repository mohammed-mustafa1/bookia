class User {
  int? userId;
  String? userName;
  String? userEmail;
  String? address;
  String? phone;

  User({
    this.userId,
    this.userName,
    this.userEmail,
    this.address,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['user_id'] as int?,
        userName: json['user_name'] as String?,
        userEmail: json['user_email'] as String?,
        address: json['address'] as String?,
        phone: json['phone'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'user_name': userName,
        'user_email': userEmail,
        'address': address,
        'phone': phone,
      };
}
