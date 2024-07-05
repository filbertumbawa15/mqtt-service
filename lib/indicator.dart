import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'mqtt_service.dart';
import 'package:provider/provider.dart';

class MqttStatusIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MqttService>(
      builder: (context, mqttService, child) {
        Color circleColor;
        switch (mqttService.connectionState) {
          case MqttConnectionState.connecting:
            circleColor = Colors.yellow;
            break;
          case MqttConnectionState.connected:
            circleColor = Colors.green;
            break;
          case MqttConnectionState.disconnected:
            circleColor = Colors.red;
            break;
          default:
            circleColor = Colors.red;
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 48.0),
          child: ClayContainer(
            color: const Color(0xFFf2f2f2),
            height: 64,
            width: 64,
            borderRadius: 50,
            curveType: CurveType.convex,
            child: Center(
              child: CircleAvatar(
                backgroundColor: circleColor,
                radius: 10,
              ),
            ),
          ),
        );
      },
    );
  }
}
