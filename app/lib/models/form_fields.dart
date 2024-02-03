import 'package:form_validator/form_validator.dart';

class FormFields {
  final String label;
  final String errorMessage;
  final String? Function(String?)? validator;
  String value;
  FormFields({
    required this.label,
    required this.errorMessage,
    this.validator,
    this.value = "",
  });
}

final nameField = FormFields(
  label: "Name",
  errorMessage: "Please enter your name",
  validator:
      ValidationBuilder().required("We would love to know you better").build(),
);

final emailField = FormFields(
  label: "Email",
  errorMessage: "Please enter your email",
  validator: ValidationBuilder().email().build(),
);

final passwordField = FormFields(
  label: "Password",
  errorMessage: "Please enter your password",
  validator: ValidationBuilder()
      .required("This is needed for your own security")
      .minLength(4)
      .build(),
);

final confirmPasswordField = FormFields(
  label: "Confirm Password",
  errorMessage: "Please enter your confirm password",
  validator: ValidationBuilder()
      .required("Please confirm your password")
      .add((value) =>
          passwordField.value == value ? null : "Passwords do not match")
      .build(),
);
