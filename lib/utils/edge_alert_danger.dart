import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';

edgeAlertWidgetDanger(context, String title) {
  return EdgeAlert.show(
    context,
    title: title,
    gravity: EdgeAlert.BOTTOM,
    backgroundColor: Colors.red,
    icon: Icons.close,
  );
}

edgeAlertWidgetDangerTop(context, String title) {
  return EdgeAlert.show(
    context,
    title: title,
    gravity: EdgeAlert.TOP,
    backgroundColor: Colors.red,
    icon: Icons.close,
  );
}
