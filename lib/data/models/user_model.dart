class UserModel {
  int age;
  String userId;
  String fullName;
  String email;
  String createdAt;

  UserModel({
    required this.age,
    required this.userId,
    required this.fullName,
    required this.email,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> josnData) {
    return UserModel(
      age: josnData['age'] as int? ?? 0,
      userId: josnData['userId'] as String? ?? '',
      fullName: josnData['fullName'] as String? ?? '',
      email: josnData['email'] as String? ?? '',
      createdAt: josnData['createdAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return ''' 
      age : $age,
      userId : $userId,
      fullName : $fullName,
      email : $email,
      createdAt : $createdAt,
      ''';
  }

  UserModel copyWith({
    int? age,
    String? userId,
    String? fullName,
    String? email,
    String? createdAt,
  }) =>
      UserModel(
        age: age ?? this.age,
        userId: userId ?? this.userId,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        createdAt: createdAt ?? this.createdAt,
      );

  

}

