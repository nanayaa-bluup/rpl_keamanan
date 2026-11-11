// lib/widgets/user_card.dart
import 'package:flutter/material.dart';
import '../models/user.dart';

/// Widget komponen kartu untuk menampilkan ringkasan data pengguna.
class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const UserCard({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Text(
            user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${user.email}\n${user.companyName}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        isThreeLine: true,
      ),
    );
  }
}