import 'package:flutter/foundation.dart';

class DataProvider with ChangeNotifier {
  String wateringSystemId;
  bool waterSystem;
  String soilMoistureId;
  double soilMoisture;
}