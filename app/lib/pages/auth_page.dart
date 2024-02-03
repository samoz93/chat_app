import 'package:app/components/custom_input.dart';
import 'package:app/models/form_fields.dart';
import 'package:app/services/locator.dart';
import 'package:app/stores/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum AuthMode {
  signIn,
  signUp,
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  showErrorMessage(err) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        err ?? "Logged in successfully",
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: err != null ? Colors.red : null,
            ),
      ),
    ));
  }

  final inputDecoration = const InputDecoration(
    labelText: "Email",
    border: OutlineInputBorder(),
  );
  Key _refreshKey = UniqueKey();
  final service = it.get<AuthStore>();
  var mode = AuthMode.signIn;
  final _key = GlobalKey<FormState>();
  void submit() async {
    if (!_key.currentState!.validate()) {
      return;
    }

    var err, data;

    if (mode == AuthMode.signIn) {
      (err, data) = await service.login(
        emailField.value,
        passwordField.value,
      );
    } else if (mode == AuthMode.signUp) {
      (err, data) = await service.signup(
        email: emailField.value,
        name: nameField.value,
        password: passwordField.value,
      );
    }
    if (err != null) {
      showErrorMessage(err.toString());
      return;
    }
    Navigator.pushNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    final inputs = mode == AuthMode.signIn
        ? [emailField, passwordField]
        : [emailField, nameField, passwordField, confirmPasswordField];

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40.h, 50.w)),
                      child: Image.network(
                        "https://icones.pro/wp-content/uploads/2021/05/icone-de-chat-violet.png",
                        height: 30.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      key: _refreshKey,
                      children: [
                        ...inputs.map(
                          (e) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: CustomInput(
                                label: e.label,
                                validator: e.validator,
                                onChanged: (value) {
                                  e.value = value;
                                },
                                prefixIcon: Icons.email,
                              ),
                            );
                          },
                        ),
                      ]
                          .animate(
                            interval: .1.seconds,
                          )
                          .shakeX(),
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: submit,
                            child: Text(
                              mode == AuthMode.signIn ? "Sign In" : "Sign Up",
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _refreshKey = UniqueKey();
                                mode = mode == AuthMode.signIn
                                    ? AuthMode.signUp
                                    : AuthMode.signIn;
                              });
                            },
                            child: Text(
                              mode == AuthMode.signIn
                                  ? "Don't have an account? Sign Up"
                                  : "Already have an account? Sign In",
                            ),
                          ),
                        ],
                      ),
                    )
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
