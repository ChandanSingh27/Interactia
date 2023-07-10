abstract class LoginMethod {
    Future<bool> loginWithEmailPassword();
    Future<bool> loginWithGoogle();
    Future<bool> loginWithPhone();
    Future<bool> forgetPassword();
}