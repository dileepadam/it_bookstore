import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../core/services/dependency_injection.dart' as di;
import '../app/base_app.dart';
import '../utils/enums.dart';
import 'flavor_config.dart';

void main() {
  runZonedGuarded(() async {
    FlavorConfig(
        flavor: Flavor.DEV, color: Colors.blue, flavorValues: FlavorValues());


    WidgetsFlutterBinding.ensureInitialized();

    di.setLocator();

    runApp(const ItBookstoreApp());
  }, (error, stack) {
    log(error.toString(), stackTrace: stack);
  });
}
