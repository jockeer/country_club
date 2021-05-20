
class FormValidator{

  bool validarEmail(String email){
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    if ( regExp.hasMatch( email ) ) {
        return true;
      } else {
        return false;
      }
  }

  bool isNumeric(String numero){
    
    final n = num.tryParse(numero);

    return (n==null) ? false : true;
    
  }
}