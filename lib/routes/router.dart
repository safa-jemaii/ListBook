import 'package:flutter/material.dart';

import '../main.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/detail': (context) => BookList(),
};
