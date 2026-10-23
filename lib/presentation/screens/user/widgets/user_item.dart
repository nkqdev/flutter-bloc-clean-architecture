import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/user/user.dart';

class UserItem extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;

  const UserItem({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: user.avatar != null
            ? NetworkImage(user.avatar!)
            : null,
        child: user.avatar == null
            ? Text(user.fullName.isNotEmpty ? user.fullName[0] : '?')
            : null,
      ),
      title: Text(user.fullName),
      subtitle: user.email != null ? Text(user.email!) : null,
    );
  }
}
