class UserModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String role;
  final String city; // Changed to handle empty/null
  final DateTime? dateOfBirth;
  final bool active;
  final String? profilePicture; // Added for potential URL
  final String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
    required this.city,
    this.dateOfBirth,
    required this.active,
    this.profilePicture,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, {String? token}) {
    final userData = json['data']['user'];
    return UserModel(
      id: userData['id'] ?? userData['_id'],
      name: userData['name'] ?? '',
      phoneNumber: userData['phoneNumber'] ?? '',
      role: userData['role'] ?? 'user',
      city: userData['city'] ?? '',
      dateOfBirth: userData['dateOfBirth'] != null ? DateTime.tryParse(userData['dateOfBirth']) : null,
      active: userData['active'] ?? false,
      profilePicture: userData['profilePicture'],
      token: token,
    );
  }
}
