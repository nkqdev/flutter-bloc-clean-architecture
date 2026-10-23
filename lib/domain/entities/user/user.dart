import 'package:meta/meta.dart';

@immutable
class User {
  final String id;
  final String fullName;
  final String? email;
  final String? phoneNumber;
  final String? avatar;
  final DateTime? createdAt;

  const User({
    required this.id,
    required this.fullName,
    this.email,
    this.phoneNumber,
    this.avatar,
    this.createdAt,
  });
}
