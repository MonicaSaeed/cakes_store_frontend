extension StringExtensions on String {
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Password validation containing at least 8 characters, one uppercase letter, one lowercase letter, one number, and one special character
  bool get isValidPassword {
    final passwordRegex = RegExp(
      // r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
      // contain only 8 characters
      r'^[a-zA-Z0-9\s.,-]{8,}$',
    );
    return passwordRegex.hasMatch(this);
  }

  /// User name validation containing only alphanumeric characters and underscores, with a length between 3 and 20 characters
  bool get isValidName {
    final usernameRegex = RegExp(r'^[a-zA-Z_]{3,20}$');
    return usernameRegex.hasMatch(this);
  }

  /// Phone number validation containing only digits, with a length of 11 started with (012 or 010 or 011 or 015)
  bool get isValidPhoneNumber {
    final phoneRegex = RegExp(r'^(010|011|012|015)[0-9]{8}$');
    return phoneRegex.hasMatch(this);
  }

  /// Address validation containing alphanumeric characters, numbers, spaces, and punctuation, with a length between 5 and 100 characters
  bool get isValidAddress {
    final addressRegex = RegExp(r'^[a-zA-Z0-9\s.,-]{5,100}$');
    return addressRegex.hasMatch(this);
  }
}
