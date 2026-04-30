import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/core/error/exception.dart';
import 'package:furniture_app/core/error/failures.dart';

class AppInterceptor {
  static Failure handleException(dynamic error) {
    // 🔐 Firebase Auth Errors
    if (error is FirebaseAuthException) {
      return AuthFailure(_mapFirebaseAuthError(error));
    }

    // 🌐 Network
    if (error is NetworkException) {
      return const NetworkFailure("No Internet Connection");
    }

    // 🗄 Database
    if (error is DatabaseException) {
      return const DatabaseFailure("Database Error");
    }

    // ❌ Unknown
    return const ServerFailure("Something went wrong");
  }

  // 🔥 FULL AUTH ERROR MAPPING
  static String _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return "Invalid email address";

      case 'user-disabled':
        return "User account disabled";

      case 'user-not-found':
        return "No user found with this email";

      case 'wrong-password':
        return "Incorrect password";

      case 'email-already-in-use':
        return "Email already registered";

      case 'operation-not-allowed':
        return "Operation not allowed";

      case 'weak-password':
        return "Password is too weak";

      case 'too-many-requests':
        return "Too many attempts. Try again later";

      case 'network-request-failed':
        return "Check your internet connection";

      case 'invalid-credential':
        return "Invalid credentials";

      case 'account-exists-with-different-credential':
        return "Account exists with different sign-in method";

      case 'credential-already-in-use':
        return "Credential already in use";

      case 'requires-recent-login':
        return "Please login again to continue";

      case 'provider-already-linked':
        return "Provider already linked";

      case 'no-such-provider':
        return "Provider not found";

      case 'invalid-verification-code':
        return "Invalid verification code";

      case 'invalid-verification-id':
        return "Invalid verification ID";

      case 'session-expired':
        return "Session expired. Try again";

      case 'quota-exceeded':
        return "Quota exceeded. Try later";

      case 'missing-email':
        return "Email is required";

      case 'missing-password':
        return "Password is required";

      case 'invalid-phone-number':
        return "Invalid phone number";

      case 'missing-phone-number':
        return "Phone number is required";

      default:
        return "Authentication failed";
    }
  }
}
class GoogleAuthErrorMapper {
  static String map(String error) {
    switch (error) {
      case 'sign_in_canceled':
        return "Google sign-in canceled";

      case 'network_error':
        return "Network error during Google sign-in";

      case 'sign_in_failed':
        return "Google sign-in failed";

      case 'invalid_account':
        return "Invalid Google account";

      default:
        return "Google authentication failed";
    }
  }
}