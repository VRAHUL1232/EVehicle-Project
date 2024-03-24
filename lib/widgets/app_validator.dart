
class AppValidator{
    String? validateEmail(value) {
    if (value!.isEmpty) {
      return "Please enter an email";
    }
    RegExp emailRegExp = RegExp(
        r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
    if (!emailRegExp.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? validateUsername(value) {
    if (value!.isEmpty) {
      return "Please enter a username";
    }
    if (value.length < 6) {
      return "Username should be atleast 6 characters";
    }
    return null;
  }

  String? validatePassword(value) {
    if (value!.isEmpty) {
      return "Please enter a password";
    }
    if(value.length < 8){
      return 'Password must be atleast 8 characters';
    }
    RegExp passwordValidator= RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (!passwordValidator.hasMatch(value)) {
      return "Must have atleast 1 uppercase, lowercase, special characters, numeric number";
    }
    return null;
  }

  String? isEmptyName(value){
    if(value!.isEmpty){
      return 'Please enter the details';
    }
    return null;
  }

}