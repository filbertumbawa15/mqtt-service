import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService with ChangeNotifier {
  final String serverUri = 'broker.hivemq.com';
  final int port = 1883;
  final String clientId = 'flutter_client';

  late MqttServerClient client;

  MqttConnectionState connectionState = MqttConnectionState.disconnected;

  MqttService() {
    client = MqttServerClient(serverUri, clientId);
    client.port = port;
    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
  }

  void connect() async {
    connectionState = MqttConnectionState.connecting;
    notifyListeners();
    try {
      await client.connect();
    } on Exception catch (e) {
      print('Error: $e');
      disconnect();
    }
  }

  void disconnect() {
    client.disconnect();
    connectionState = MqttConnectionState.disconnected;
    notifyListeners();
  }

  void onDisconnected() {
    connectionState = MqttConnectionState.disconnected;
    notifyListeners();
    print('MQTT Client Disconnected');
  }

  void onConnected() {
    connectionState = MqttConnectionState.connected;
    notifyListeners();
    print('MQTT Client Connected');
  }

  void onSubscribed(String topic) {
    print('Subscribed to $topic');
  }

  void subscribeToTopic(String topic) {
    client.subscribe(topic, MqttQos.atMostOnce);
  }

  void publishMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }
}
