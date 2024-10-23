import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String email;
  final String username;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  /// Helper function to egt full name
  String get fullName => '$firstName $lastName';

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Static function to generate a user name the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = '$firstName$lastName';
    String usernameWithPrefix = 'cwt_$camelCaseUsername';
    return usernameWithPrefix;
  }

  /// Static function to create an empty user model.
  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      username: '',
      email: '',
      phoneNumber: '',
      profilePicture: '');

  /// Convert model to JSON structure for storing data in firestore
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'id': id,
      'lastName': lastName,
      'userName': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
    };
  }

  /// Factory method to create a usermodel form firebase document snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) {
      throw UserModel.empty();
    }
    print('User data from user_model============>>>>>>>>>>>> ${data}');
    try {
      return UserModel(
        id: document.id,
        firstName: data['firstName'] as String? ?? '',
        lastName: data['lastName'] as String? ?? '',
        username: data['userName'] as String? ?? '',
        email: data['email'] as String? ?? '',
        phoneNumber: data['phoneNumber'] as String? ?? '',
        profilePicture: data['profilePicture'] as String? ?? '',
      );
    } catch (e) {
      print('Error parsing user data: $e');
      throw Exception('Error parsing user data');
    }
  }
}
