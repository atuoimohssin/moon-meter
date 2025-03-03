import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moon and Sun Distance Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DistanceCalculator(),
    );
  }
}

class DistanceCalculator extends StatefulWidget {
  @override
  _DistanceCalculatorState createState() => _DistanceCalculatorState();
}

class _DistanceCalculatorState extends State<DistanceCalculator> {
  double? _latitude;
  double? _longitude;
  double? _moonDistance;
  double? _sunDistance;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
      _calculateDistances();
    });
  }

  void _calculateDistances() {
    // Approximate average distances (in kilometers)
    const double moonDistance = 384400;
    const double sunDistance = 149600000;

    // Simple trigonometric calculations (not accurate, for demonstration purposes)
    _moonDistance = sqrt(pow(moonDistance, 2) + pow(_latitude!, 2) + pow(_longitude!, 2));
    _sunDistance = sqrt(pow(sunDistance, 2) + pow(_latitude!, 2) + pow(_longitude!, 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moon and Sun Distance Calculator'),
      ),
      body: Center(
        child: _latitude == null || _longitude == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Latitude: $_latitude'),
                  Text('Longitude: $_longitude'),
                  SizedBox(height: 20),
                  Text('Distance to Moon: ${_moonDistance?.toStringAsFixed(2)} km'),
                  Text('Distance to Sun: ${_sunDistance?.toStringAsFixed(2)} km'),
                ],
              ),
      ),
    );
  }
}