class UserModel {
  int age;
  String userId;
  String fullName;
  String email;
  String createdAt;
  String imageUrl;

  UserModel({
    required this.age,
    required this.userId,
    required this.fullName,
    required this.email,
    required this.createdAt,
    required this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> josnData) {
    return UserModel(
      age: josnData['age'] as int? ?? 0,
      userId: josnData['userId'] as String? ?? '',
      fullName: josnData['fullName'] as String? ?? '',
      email: josnData['email'] as String? ?? '',
      imageUrl: josnData['imageUrl'] as String? ?? '',
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
      'imageUrl': imageUrl,
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
      imageUrl : $imageUrl,
      ''';
  }
}