class TemperatureAverage {

  /*26. Se ingresan 10 pares de temperaturas (T1 y T2). Hallar el promedio
de las temperaturas T1 y el promedio de las temperaturas T2.
*/

  double calculateAverage(List<double> temperatures) {
    double sumTemperatures = 0;
    for (int i = 0; i < temperatures.length; i++) {
      sumTemperatures += temperatures[i];
    }
    return sumTemperatures / temperatures.length;
  }


}