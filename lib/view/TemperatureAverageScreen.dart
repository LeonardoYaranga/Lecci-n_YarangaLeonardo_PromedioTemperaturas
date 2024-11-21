import 'package:flutter/material.dart';
import '../controller/TemperatureAverage.dart';

class TemperatureAverageScreen extends StatefulWidget {
  const TemperatureAverageScreen({super.key});

  @override
  State<TemperatureAverageScreen> createState() =>
      TemperatureAverageScreenState();
}

class TemperatureAverageScreenState extends State<TemperatureAverageScreen> {
  final TemperatureAverage temperatureAverage = TemperatureAverage();
  final List<double> temperaturesT1 = [];
  final List<double> temperaturesT2 = [];
  final TextEditingController _controllerTemperatureT1 = TextEditingController();
  final TextEditingController _controllerTemperatureT2 = TextEditingController();
  String averageT1 = '';
  String averageT2 = '';
  
  String message = '';

  void _addTemperatures() {
    final t1 = double.tryParse(_controllerTemperatureT1.text);
    final t2 = double.tryParse(_controllerTemperatureT2.text);

    if (t1 != null && t2 != null) {
      if (temperaturesT1.length < 10 && temperaturesT2.length < 10) {
        setState(() {
          temperaturesT1.add(t1);
          temperaturesT2.add(t2);
          _controllerTemperatureT1.clear();
          _controllerTemperatureT2.clear();
          message = 'Par de temperaturas agregado correctamente.';
        });
      } else {
        setState(() {
          message = 'No puede ingresar más de 10 pares de temperaturas. Ahora calcule el promedio';
        });
      }
    } else {
      setState(() {
        message = 'Por favor, ingrese valores válidos para ambas temperaturas.';
      });
    }
  }

  void _calculateAverages() {
    if (temperaturesT1.length == 10 && temperaturesT2.length == 10) {
      final avgT1 = temperatureAverage.calculateAverage(temperaturesT1);
      final avgT2 = temperatureAverage.calculateAverage(temperaturesT2);

      setState(() {
        averageT1 = avgT1.toStringAsFixed(2);
        averageT2 = avgT2.toStringAsFixed(2);
        message = 'Promedios calculados correctamente.';
      });
    } else {
      setState(() {
        message = 'Debe ingresar 10 pares de temperaturas antes de calcular los promedios.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promedio de Temperaturas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ingrese las temperaturas T1 y T2:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controllerTemperatureT1,
              decoration: const InputDecoration(
                labelText: 'Temperatura T1',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controllerTemperatureT2,
              decoration: const InputDecoration(
                labelText: 'Temperatura T2',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            if (message.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                message,
                style: TextStyle(
                  color: message.contains('correctamente') ? Colors.green : Colors.red,
                ),
              ),
            ],
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addTemperatures,
              child: const Text('Agregar'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateAverages,
              child: const Text('Calcular Promedios'),
            ),
            Text("Temperatura T1: $temperaturesT1",
              style: const TextStyle(fontSize: 18),
            ),
            Text("Temperatura T2: $temperaturesT2",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            if (averageT1.isNotEmpty && averageT2.isNotEmpty) ...[
              Text(
                'Promedio de T1: $averageT1',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'Promedio de T2: $averageT2',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
