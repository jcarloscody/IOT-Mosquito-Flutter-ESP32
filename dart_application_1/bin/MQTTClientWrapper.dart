// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:io';

// import 'package:mqtt5_client/mqtt5_client.dart';
// import 'package:mqtt_client/mqtt_client.dart' as mqt;
// import 'package:mqtt_client/mqtt_server_client.dart' as mqts;

// import 'enums.dart';

// class MQTTClientWrapper {
// //   client.secure = true;
// // client.securityContext = SecurityContext.defaultContext;
//   var client = mqts.MqttServerClient.withPort(
//       'fe65a26d8a524e6e9f90780d2307503b.s2.eu.hivemq.cloud', 'josue', 8883);

//   MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
//   MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;
//   MQTTClientWrapper() {
//     client.secure = true;
//     client.securityContext = SecurityContext.defaultContext;
//     client.keepAlivePeriod = 200000000000000;
//     client.onDisconnected = onDisconnected;
//     client.onConnected = onConnected;
//     client.onSubscribed = onSubscribed;
//   }

//   // using async tasks, so the connection won't hinder the code flow
//   void prepareMqttClient() async {
//     // _setupMqttClient();
//     await connectClient();
//     subscribeToTopic('temperatura');
//     publishMessage('Hello');
//   }

//   // waiting for the connection, if an error occurs, print it and disconnect
//   Future<void> connectClient() async {
//     try {
//       print('client connecting....');
//       connectionState = MqttCurrentConnectionState.CONNECTING;
//       await client.connect('josue', '123456789');
//     } on Exception catch (e) {
//       print('client exception - $e');
//       connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
//       client.disconnect();
//     }
//     print('client connected ${client.connectionStatus!.state}');

//     // when connected, print a confirmation, else print an error
//     if (client.connectionStatus != null &&
//         client.connectionStatus!.state.index ==
//             MqttConnectionState.connected.index) {
//       connectionState = MqttCurrentConnectionState.CONNECTED;
//       print('client connected ${client.connectionStatus!.state}');
//     } else {
//       print(
//           'ERROR client connection failed - disconnecting, status is ${client.connectionStatus}');
//       connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
//       client.disconnect();
//     }
//   }

//   // void _setupMqttClient() {
//   //   // the next 2 lines are necessary to connect with tls, which is used by HiveMQ Cloud
//   // }

//   void subscribeToTopic(String topicName) {
//     print('Subscribing to the $topicName topic');

//     client.subscribe(topicName, mqt.MqttQos.atMostOnce);

//     // print the message when it is received
//     client.updates!.listen(
//       (event) {
//         for (var element in event) {
//           final mqt.MqttPublishMessage mqttMessage =
//               element.payload as mqt.MqttPublishMessage;
//           final String payload = String.fromCharCodes(
//               mqttMessage.payload.message!.map((element) => element));
//           print(">>>>>>  $payload");
//         }
//         // final MqttPublishMessage recMess = c[0].payload;
//         // var message =
//         //     MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

//         // print('YOU GOT A NEW MESSAGE:');
//         // print(message);
//       },
//     );
//   }

//   void publishMessage(String message) {
//     if (client.connectionStatus != null &&
//         client.connectionStatus!.state.index ==
//             MqttConnectionState.connected.index) {
//       final builder = MqttPayloadBuilder();
//       builder.addString(message); // Valor da temperatura

//       client.publishMessage(
//           'temperatura', mqt.MqttQos.exactlyOnce, builder.payload!);
//       print('Mensagem publicada');
//     }

//     // final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
//     // builder.addString(message);

//     // print(
//     //     'Publishing message "$message" to topic ${'Dart/Mqtt_client/testtopic'}');
//     // client.publishMessage(
//     //     'Dart/Mqtt_client/testtopic', MqttQos.exactlyOnce, builder.payload);
//   }

//   // callbacks for different events
//   void onSubscribed(String topic) {
//     print('Subscription confirmed for topic $topic');
//     subscriptionState = MqttSubscriptionState.SUBSCRIBED;
//   }

//   void onDisconnected() {
//     print('OnDisconnected client callback - Client disconnection');
//     connectionState = MqttCurrentConnectionState.DISCONNECTED;
//   }

//   void onConnected() {
//     connectionState = MqttCurrentConnectionState.CONNECTED;
//     print('OnConnected client callback - Client connection was sucessful');
//   }
// }
