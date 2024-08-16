extension StringX on String {
  // Email Validation
  String? validateEmail() {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp("$pattern");
    if (!regex.hasMatch(this)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Password Validation
  String? validatePassword() {
    if (isEmpty) {
      return 'Password cannot be empty';
    } else if (length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(r'[A-Z]').hasMatch(this)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'[a-z]').hasMatch(this)) {
      return 'Password must contain at least one lowercase letter';
    } else if (!RegExp(r'[0-9]').hasMatch(this)) {
      return 'Password must contain at least one number';
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(this)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  // Confirm Password Validation
  String? validateConfirmPassword(String password) {
    if (this != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Empty Validation
  String? emptyValidation() {
    if (isEmpty) {
      return 'Required';
    }
    return null;
  }
}
