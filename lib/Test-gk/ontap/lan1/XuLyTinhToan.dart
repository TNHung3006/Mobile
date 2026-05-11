class Xulytinhtoan {
  static const double tylechuyendoi = 2.54;

  static double cmToinches(double cm){
    return cm = cm / tylechuyendoi;
  }
  static double inchesTocm(double inches){
    return inches = inches * tylechuyendoi;
  }
  static String taoChuoiLichSuCmToInches(double cm, double inches){
    return "${cm.toStringAsFixed(1)} cm = ${inches.toStringAsFixed(3)} inches";
  }

  static String taoChuoiLichSuInchesToCm(double cm, double inches){
    return "${inches.toStringAsFixed(3)} inches = ${cm.toStringAsFixed(1)} cm";
  }
}