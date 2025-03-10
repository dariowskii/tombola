import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tombola/features/admin_screen/presentation/create_session_modal.dart';
import 'package:tombola/features/admin_screen/presentation/sessions_list.dart';
import 'package:tombola/router/routes.dart';
import 'package:tombola/utils/extensions.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  void _askLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Esci'),
          content: const Text('Sei sicuro di voler uscire?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'No',
                style: TextStyle(
                  color: context.textTheme.bodySmall?.color,
                ),
              ),
            ),
            TextButton(
              onPressed: _logoutUser,
              child: Text(
                'Si',
                style: TextStyle(
                  color: context.colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _logoutUser() async {
    Navigator.pop(context);
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;

    const WelcomeRoute().go(context);
  }

  void _showCreateSessionModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const CreateSessionModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        actions: [
          IconButton(
            onPressed: _askLogoutConfirmation,
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: const SessionsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateSessionModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
