import 'dart:async';

import 'package:dart_application_1/dart_application_1.dart'
    as dart_application_1;
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';

import 'MQTTClientWrapper.dart';
// import 'package:mqtt5_client/mqtt5_client.dart';
// import 'package:mqtt5_client/mqtt5_server_client.dart';

void main(List<String> arguments) async {
  final mqttClient = MqttServerClient('localhost', '1883');

  // Defina a função de callback para lidar com as mensagens recebidas
  mqttClient.onDisconnected = () {
    print('Desconectado');
  };

  // Conecte-se ao broker MQTT
  await mqttClient.connect();

  // Verifique se a conexão foi estabelecida
  if (mqttClient.connectionStatus!.state == MqttConnectionState.connected) {
    // Publicar mensagem no tópico "temperatura"
    final builder = MqttPayloadBuilder();
    builder.addString('25.5'); // Valor da temperatura
    // Timer.periodic(Duration(seconds: 3), (timer) {
    //   mqttClient.publishMessage(
    //       'temperatura', MqttQos.exactlyOnce, builder.payload!);
    //   // print('Mensagem publicada');
    // });

    mqttClient.subscribe('temperatura', MqttQos.exactlyOnce);
  }
  mqttClient.updates.listen((event) {
    for (var element in event) {
      // print("TOPICO >> \n ${element.topic}");
      // print("STRING >>> \n ${element.payload.toString()}");
      final MqttPublishMessage mqttMessage =
          element.payload as MqttPublishMessage;
      final String payload = String.fromCharCodes(
          mqttMessage.payload.message!.map((element) => element));
      print(">>>>>>  $payload");
    }
  });

  // mqttClient.disconnect();

  // MQTTClientWrapper newclient = MQTTClientWrapper();
  // newclient.subscribeToTopic("luminosidade");
  // await newclient.connectClient();

  // while (true) {
  //   await Future.delayed(
  //     Duration(seconds: 5),
  //     () async {
  //       // await newclient.connectClient();
  //       await newclient.connectClient();

  //       newclient.publishMessage("alive");
  //     },
  //   );
}

  // final String broker = 'fe65a26d8a524e6e9f90780d2307503b.s2.eu.hivemq.cloud';
  // final String username = 'josue';
  // final String password = '123456789';

  // // Crie um cliente MQTT para publicação
  // final client = MqttServerClient.withPort(broker, 'josue', 8883);

  // // Defina as credenciais de autenticação
  // client.connect(username, password);

  // // Conecte-se ao broker MQTT
  // client.connect();

  // while (true) {
  //   if (client.connectionStatus != null &&
  //       client.connectionStatus!.state.index ==
  //           MqttConnectionState.connected.index) {
  //     // Publicar uma mensagem em um tópico
  //     final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
  //     builder.addString('Hello from publisher');
  //     client.publishMessage('my/topic', MqttQos.exactlyOnce, builder.payload!);
  //     print("----------->>>>");
  //   }
  //   await Future.delayed(
  //     Duration(seconds: 2),
  //     () {},
  //   );
  // }

  // // Desconecte o cliente após a publicação
  // client.disconnect();
// }
