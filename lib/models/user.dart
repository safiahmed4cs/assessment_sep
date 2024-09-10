class User {
  final String fullName;
  final String mobile;
  final bool isVerified;

  User({
    required this.isVerified,
    required this.fullName,
    required this.mobile,
  });

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'mobile': mobile,
        'isVerified': isVerified,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      mobile: json['mobile'],
      isVerified: json['isVerified'],
    );
  }
}
