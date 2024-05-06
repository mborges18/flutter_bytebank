import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'application.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    kIsWeb ? DevicePreview(
        enabled: true,
        builder: (context) => const Application()
      ) : const Application()
  );
}
