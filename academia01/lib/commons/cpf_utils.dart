class CpfUtils {

  //"12345678901" -> "123.456.789-01"
  static String formatador(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cpf.length != 11) {
      return cpf;
    }
    return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9, 11)}';
  }
  
  //"123.456.789-01" -> "12345678901"
  static String desformatador(String cpf) {
    return cpf.replaceAll(RegExp(r'[^0-9]'), '');
  }

  static bool isValidCpf(String cpf) {
    cpf = desformatador(cpf);
    
    if (cpf.length != 11) {
      return false;
    }
    return true;
  }
}
