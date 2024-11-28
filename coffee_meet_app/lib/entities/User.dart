class User {
  final int id;
  final String name;
  final String password;
  final String email;
  final int phone;
  final String occupation;
  final String facebookUrl;
  final String linkedInUrl;
  final bool showSocialMedia;
  final bool isAvailable;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.phone,
    required this.occupation,
    this.facebookUrl = '',
    this.linkedInUrl = '',
    this.showSocialMedia = false,
    this.isAvailable = false,
  });

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'email': email,
      'phone': phone ?? 00000,
      'occupation': occupation ?? 'None',
      'facebookUrl': facebookUrl ?? '',
      'linkedInUrl': linkedInUrl ?? '',
      'showSocialMedia': showSocialMedia ?? true,
      'isAvailable': isAvailable ?? false,
    };
  }

  static User fromJSON(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      email: json['email'],
      phone: json['phone'],
      occupation: json['occupation'],
      facebookUrl: json['facebookUrl'] ?? '',
      linkedInUrl: json['linkedInUrl'] ?? '',
      showSocialMedia: json['showSocialMedia'] ?? true,
      isAvailable: json['isAvailable'] ?? false,
    );
  }
}
