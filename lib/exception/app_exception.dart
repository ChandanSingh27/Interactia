
class AppException implements Exception {
    String message;

    AppException(this.message);
}

class InvalidEmailException extends AppException{
  InvalidEmailException(super.message);
}