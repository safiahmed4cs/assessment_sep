class User {
  final String userId;
  final String fullName;
  final String mobile;
  final bool isVerified;

  User({
    required this.userId,
    required this.isVerified,
    required this.fullName,
    required this.mobile,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'fullName': fullName,
        'mobile': mobile,
        'isVerified': isVerified,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      fullName: json['fullName'],
      mobile: json['mobile'],
      isVerified: json['isVerified'],
    );
  }
}
