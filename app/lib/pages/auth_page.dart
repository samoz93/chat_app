import 'dart:async';
import 'dart:ui';

import 'package:app/components/custom_input.dart';
import 'package:app/models/form_fields.dart';
import 'package:app/services/locator.dart';
import 'package:app/stores/auth_store.dart';
import 'package:app/utils/ShaderView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:widget_mask/widget_mask.dart';

enum AuthMode {
  signIn,
  signUp,
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  static const route = "/auth";
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
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
  final _authStore = it.get<AuthStore>();
  var mode = AuthMode.signIn;
  final _key = GlobalKey<FormState>();
  void submit() async {
    if (!_key.currentState!.validate()) {
      return;
    }

    var err, data;

    if (mode == AuthMode.signIn) {
      (err, data) = await _authStore.login(
        emailField.value,
        passwordField.value,
      );
    } else if (mode == AuthMode.signUp) {
      (err, data) = await _authStore.signup(
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

  FragmentShader? shader;
  Future<FragmentShader> getShader() async {
    final frag = await FragmentProgram.fromAsset("shaders/fragment.frag");
    shader = frag.fragmentShader();
    return shader!;
  }

  final _val = ValueNotifier(0.0);
  var _ticker;
  @override
  void initState() {
    super.initState();
    _ticker ??= createTicker((elapsed) {
      final double elapsedSeconds = elapsed.inMilliseconds / 1000;
      shader?.setFloat(0, elapsedSeconds);
      _val.value = elapsedSeconds;
    });
    if (_ticker.isActive) _ticker.stop();
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  final _keyAll = UniqueKey();
  @override
  Widget build(BuildContext context) {
    final inputs = mode == AuthMode.signIn
        ? [emailField, passwordField]
        : [emailField, nameField, passwordField, confirmPasswordField];

    return Scaffold(
      body: FutureBuilder<FragmentShader>(
        future: getShader(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          final shader = snapshot.data!;
          return BackdropFilter(
              key: _keyAll,
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(.9),
                child: Center(
                  child: Form(
                    key: _key,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: 100.h,
                        child: Flex(
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WidgetMask(
                              mask: CustomPaint(
                                painter: ShaderPainter(
                                  shader: shader,
                                  repaint: _val,
                                ),
                              ),
                              childSaveLayer: true,
                              blendMode: BlendMode.srcIn,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.h),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 20.sp,
                                  ),
                                  child: Image.network(
                                    "https://icones.pro/wp-content/uploads/2021/05/icone-de-chat-violet.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              key: _refreshKey,
                              children: [
                                ...inputs.map(
                                  (e) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: CustomInput(
                                        label: e.label,
                                        validator: e.validator,
                                        onChanged: (value) {
                                          e.value = value;
                                        },
                                        prefixIcon: Icons.email,
                                        isExpanded: false,
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
                            Flexible(
                              flex: 1,
                              fit: FlexFit.loose,
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: submit,
                                    child: Text(
                                      mode == AuthMode.signIn
                                          ? "Sign In"
                                          : "Sign Up",
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
              ));
        },
      ),
    );
  }
}
