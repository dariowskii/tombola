import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tombola/router/routes.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();

  late final _formKey = GlobalKey<FormState>();

  var _isLogging = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _tryLogin() async {
    if (_formKey.currentState?.validate() == false) {
      return;
    }

    setState(() {
      _isLogging = true;
    });

    try {
      final email = _emailController.text;
      final password = _passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        return;
      }

      final _ = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!mounted) return;

      const AdminRoute().go(context);
    } on FirebaseAuthException catch (e) {
      final message = e.message ?? 'Errore sconosciuto';
      if (mounted) {
        context.showSnackBar(message);
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLogging = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double minSize = min(500, context.width * 0.8);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          Spacing.medium.value,
        ),
        child: Center(
          child: SizedBox(
            width: minSize,
            child: AutofillGroup(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      enabled: !_isLogging,
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: [AutofillHints.email],
                      onTap: _isLogging
                          ? null
                          : () {
                              Scrollable.ensureVisible(
                                context,
                                duration: 500.ms,
                                curve: Curves.decelerate,
                              );
                            },
                      onTapUpOutside: (_) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Inserisci la l\'email';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text('Email'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    Spacing.small.h,
                    TextFormField(
                      enabled: !_isLogging,
                      controller: _passwordController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: [AutofillHints.password],
                      obscureText: true,
                      onTap: _isLogging
                          ? null
                          : () {
                              Scrollable.ensureVisible(
                                context,
                                duration: 500.ms,
                                curve: Curves.decelerate,
                              );
                            },
                      onTapUpOutside: (_) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onFieldSubmitted: (_) {
                        _tryLogin();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Inserisci la password';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text('Password'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    Spacing.large.h,
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _isLogging ? null : _tryLogin,
                        child: _isLogging
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Entra'),
                                  Spacing.medium.w,
                                  SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: context.colorScheme.onPrimary,
                                    ),
                                  ),
                                ],
                              )
                            : const Text('Entra'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
