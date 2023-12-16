class OrderHelper {
  static Map<String, dynamic> calculateTimePedido(String inputDate) {
    DateTime currentDate = DateTime.now();
    DateTime pastDate = DateTime.parse(inputDate);

    Duration difference = currentDate.difference(pastDate);
    int elapsedMinutes = difference.inMinutes;

    if (elapsedMinutes < 60) {
      String horaString = '$elapsedMinutes min';
      return {'hora': 0, 'minutos': elapsedMinutes, 'horaString': horaString};
    } else {
      int elapsedHours = (elapsedMinutes / 60).floor();
      int remainingMinutes = elapsedMinutes % 60;

      String horaString = elapsedHours > 0
          ? '${elapsedHours}hr ${remainingMinutes}min'
          : '${remainingMinutes}min';

      return {
        'hora': elapsedHours,
        'minutos': elapsedMinutes,
        'horaString': horaString
      };
    }
  }
}
