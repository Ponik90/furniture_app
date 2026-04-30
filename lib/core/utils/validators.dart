mixin ValidatorsMixin {
  // 📧 EMAIL
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    final emailRegex =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return "Enter valid email";
    }

    return null;
  }

  // 📱 PHONE (INDIA)
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }

    if (value.length != 10) {
      return "Phone must be 10 digits";
    }

    final phoneRegex = RegExp(r'^[6-9]\d{9}$');

    if (!phoneRegex.hasMatch(value)) {
      return "Enter valid phone number";
    }

    return null;
  }

  // 🔐 PASSWORD
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }

  // 🔁 CONFIRM PASSWORD
  String? validateConfirmPassword(
      String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Confirm password is required";
    }

    if (value != password) {
      return "Passwords do not match";
    }

    return null;
  }

  // 🧑 NAME
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }

    if (value.length < 2) {
      return "Name too short";
    }

    return null;
  }

  // 💬 COMMON REQUIRED
  String? validateRequired(String? value,
      {String fieldName = "Field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }

    return null;
  }
}