class UserModel {
  String id;
  String name;
  String email;
  String number;
  String image;
  String role;

  // Constructor with default values
  UserModel({
    this.id = '',
    this.name = 'Unknown',
    this.email = 'no-email@example.com',
    this.number = '0000000000',
    this.image = '',
    this.role = 'user',
  });

  // Factory constructor for creating a new UserModel instance from a map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Unknown',
      email: json['email'] ?? 'no-email@example.com',
      number: json['number'] ?? '0000000000', // Corrected typo here
      image: json['image'] ?? '',
      role: json['role'] ?? 'user',
    );
  }

  // Method to convert a UserModel instance to a map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'number': number,
      'image': image,
      'role': role,
    };
  }
}
