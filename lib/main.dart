import 'dart:math';

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_motor_control/indicator.dart';
import 'package:mqtt_motor_control/mqtt_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Color baseColor = Color(0xFFf2f2f2);
  final MqttService mqttService = MqttService();

  @override
  void initState() {
    super.initState();
    mqttService.connect();
  }

  @override
  void dispose() {
    mqttService.disconnect();
    super.dispose();
  }

  void sendCommand(String command) {
    mqttService.publishMessage(
        "motor/control", '{"action": "$command", "speed": 1024}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: baseColor,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Transform.scale(
          scale: 1.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform.rotate(
                angle: pi / 4,
                child: ClayContainer(
                  color: baseColor,
                  height: 130,
                  width: 130,
                  borderRadius: 75,
                  depth: 10,
                  spread: 40,
                  curveType: CurveType.concave,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                print('asdf');
                                sendCommand("forward");
                              },
                              child: ClayContainer(
                                color: baseColor,
                                height: 45,
                                width: 45,
                                customBorderRadius: const BorderRadius.only(
                                  topLeft: Radius.elliptical(150, 150),
                                  bottomRight: Radius.circular(50),
                                ),
                                child: Transform.rotate(
                                  angle: -pi / 2 - pi / 4,
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.grey,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 12,
                            ),
                            GestureDetector(
                              onTap: () {
                                sendCommand("right");
                              },
                              child: ClayContainer(
                                color: baseColor,
                                height: 45,
                                width: 45,
                                customBorderRadius: const BorderRadius.only(
                                    topRight: Radius.elliptical(150, 150),
                                    bottomLeft: Radius.circular(50)),
                                child: Transform.rotate(
                                  angle: -pi / 4,
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.grey,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                sendCommand("left");
                              },
                              child: ClayContainer(
                                color: baseColor,
                                height: 45,
                                width: 45,
                                customBorderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.elliptical(150, 150),
                                    topRight: Radius.circular(50)),
                                child: Transform.rotate(
                                  angle: -pi / 4 - pi,
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.grey,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 12,
                            ),
                            GestureDetector(
                              onTap: () {
                                sendCommand("backward");
                              },
                              child: ClayContainer(
                                color: baseColor,
                                height: 45,
                                width: 45,
                                customBorderRadius: const BorderRadius.only(
                                    bottomRight: Radius.elliptical(150, 150),
                                    topLeft: Radius.circular(50)),
                                child: Transform.rotate(
                                  angle: -pi / 4 + pi / 2,
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.grey,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(width: 24),
              Padding(
                padding: const EdgeInsets.only(top: 128.0),
                child: Speaker(
                    baseColor: baseColor,
                    calculatedFirstDepth: 10,
                    calculatedSecondDepth: 20,
                    calculatedThirdDepth: 30,
                    calculatedFourthDepth: 40),
              ),
              MqttStatusIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 128.0),
                child: Speaker(
                    baseColor: baseColor,
                    calculatedFirstDepth: 10,
                    calculatedSecondDepth: 20,
                    calculatedThirdDepth: 30,
                    calculatedFourthDepth: 40),
              ),
              Container(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClayContainer(
                    color: baseColor,
                    height: 50,
                    width: 50,
                    customBorderRadius: BorderRadius.circular(200),
                    child: const ButtonText("Y"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClayContainer(
                        color: baseColor,
                        height: 50,
                        width: 50,
                        customBorderRadius: BorderRadius.circular(200),
                        child: const ButtonText("X"),
                      ),
                      Container(
                        width: 48,
                      ),
                      GestureDetector(
                        onTap: () {
                          sendCommand("stop");
                        },
                        child: ClayContainer(
                          color: baseColor,
                          height: 50,
                          width: 50,
                          customBorderRadius: BorderRadius.circular(200),
                          child: const ButtonText("B"),
                        ),
                      ),
                    ],
                  ),
                  ClayContainer(
                    color: baseColor,
                    height: 50,
                    width: 50,
                    customBorderRadius: BorderRadius.circular(200),
                    child: const ButtonText("A"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonText extends StatelessWidget {
  const ButtonText(this.keyName);

  final String keyName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        keyName,
        style: const TextStyle(
            fontSize: 28,
            color: Color(0xFF555555),
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

class Speaker extends StatelessWidget {
  const Speaker({
    Key? key,
    required this.baseColor,
    required this.calculatedFirstDepth,
    required this.calculatedSecondDepth,
    required this.calculatedThirdDepth,
    required this.calculatedFourthDepth,
  }) : super(key: key);

  final Color baseColor;
  final double calculatedFirstDepth;
  final double calculatedSecondDepth;
  final double calculatedThirdDepth;
  final double calculatedFourthDepth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: ClayContainer(
          height: 100,
          width: 100,
          borderRadius: 200,
          depth: calculatedSecondDepth.toInt(),
          curveType: CurveType.convex,
          color: baseColor,
          child: Center(
            child: ClayContainer(
                height: 100,
                width: 100,
                borderRadius: 200,
                color: baseColor,
                depth: 15.toInt(),
                curveType: CurveType.convex,
                child: Center(
                    child: ClayContainer(
                  height: 50,
                  width: 50,
                  borderRadius: 200,
                  color: baseColor,
                  depth: 25.toInt(),
                  curveType: CurveType.concave,
                ))),
          ),
        ),
      ),
    );
  }
}
