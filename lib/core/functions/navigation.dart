import 'package:flutter/material.dart';

void customReplacementNavigate(BuildContext context, String route) {
  Navigator.pushReplacementNamed(context, route);
}

void customNavigate(BuildContext context, String route) {
  Navigator.pushNamed(context, route);
}
