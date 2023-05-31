import 'package:flutter/material.dart';
import 'package:iot/theme.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IOT Flutter',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'IOT Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double luminosidade = 0;
  double temperatura = 0;
  final _formKey = GlobalKey<FormState>();
  String host = '18.231.186.76';
  String topicoTem = 'tads/temperatura';
  String topicoLu = 'tads/luminosidade';
  String topicoLuOffOn = 'tads/luz';
  bool luz = false;
  MqttServerClient client =
      MqttServerClient('18.231.186.76', 'meu_aplicativo_flutter');

  @override
  void initState() {
    super.initState();
  }

  Future<void> conectIOT({required String host}) async {
    client = MqttServerClient(host, 'meu_aplicativo_flutter');
    client.logging(on: true);
    client.onConnected = () {
      client.subscribe(topicoTem, MqttQos.exactlyOnce);
      client.subscribe(topicoLu, MqttQos.exactlyOnce);
    };
    client.onDisconnected = () {};
    client.onSubscribed = (String topic) {};
    client.onSubscribeFail = (String topic) {};
    // try {
    await client
        .connect()
        .then(
          (v) => showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                    "Conectado ao host: $host \nTópicos: $topicoLu e $topicoTem"),
              );
            },
          ),
        )
        .onError((error, stackTrace) => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("problemas na conexão com o host: $host"),
                );
              },
            ));
    // } catch (e) {}

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
      messages.forEach((MqttReceivedMessage<MqttMessage> message) {
        final MqttPublishMessage payload =
            message.payload as MqttPublishMessage;
        final String topic = message.topic;
        final String messageText =
            MqttPublishPayload.bytesToStringAsString(payload.payload.message);
        if (topic == topicoLu) {
          setState(() => {luminosidade = double.parse(messageText)});
        }
        if (topic == topicoTem) {
          setState(() => {temperatura = double.parse(messageText)});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              getTemperatura(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Luminosidade',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              getLuminosidade(),
              const SizedBox(
                height: 20,
              ),
              getBotao(),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: getForm(
                    formKey: _formKey,
                    inputDecoration: inputDecoration,
                    submitForm: _submitForm),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Center(child: Text("Desenvolvido por")),
                content: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse(
                                'https://www.linkedin.com/in/josuecarlosdasilva/');
                            await launchUrl(url);
                          },
                          child: const ListTile(
                            leading: Icon(Icons.coffee),
                            title: Text('Josué'),
                            subtitle: SingleChildScrollView(
                              child: Text(
                                'Sou tão bom no que faço que até o algoritmo do Google fica com inveja da minha habilidade de busca!',
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            trailing: Icon(Icons.contact_mail_outlined),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse('');
                            await launchUrl(url);
                          },
                          child: const ListTile(
                            leading: Icon(Icons.coffee),
                            title: Text('Anderson'),
                            subtitle: SingleChildScrollView(
                              child: Text(
                                'Sou tão bom no que faço que até o algoritmo do Google fica com inveja da minha habilidade de busca!',
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            trailing: Icon(Icons.contact_mail_outlined),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse('');
                            await launchUrl(url);
                          },
                          child: const ListTile(
                            leading: Icon(Icons.coffee),
                            title: Text('Patricia'),
                            subtitle: SingleChildScrollView(
                              child: Text(
                                'Sou tão bom no que faço que até o algoritmo do Google fica com inveja da minha habilidade de busca!',
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            trailing: Icon(Icons.contact_mail_outlined),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse('');
                            await launchUrl(url);
                          },
                          child: const ListTile(
                            leading: Icon(Icons.coffee),
                            title: Text('Richard'),
                            subtitle: SingleChildScrollView(
                              child: Text(
                                'Sou tão bom no que faço que até o algoritmo do Google fica com inveja da minha habilidade de busca!',
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            trailing: Icon(Icons.contact_mail_outlined),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse('');
                            await launchUrl(url);
                          },
                          child: const ListTile(
                            leading: Icon(Icons.coffee),
                            title: Text('Clara'),
                            subtitle: SingleChildScrollView(
                              child: Text(
                                'Sou tão bom no que faço que até o algoritmo do Google fica com inveja da minha habilidade de busca!',
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            trailing: Icon(Icons.contact_mail_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.person, color: Colors.green),
      ),
    );
  }

  Form getForm(
      {required Key formKey,
      required InputDecoration inputDecoration,
      required VoidCallback submitForm}) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: TextFormField(
              decoration: inputDecoration,
              style: const TextStyle(color: Colors.black),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome';
                }
                return null;
              },
              onSaved: (value) {
                host = value!;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: TextFormField(
              decoration: inputDecoration.copyWith(
                  hintText: "Tópico Temperatura",
                  labelText: "Tópico Temperatura"),
              style: const TextStyle(color: Colors.black),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o topico Temperatura';
                }
                return null;
              },
              onSaved: (value) {
                topicoTem = value!;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: TextFormField(
              decoration: inputDecoration.copyWith(
                  hintText: "Tópico Luz", labelText: "Tópico Luz"),
              style: const TextStyle(color: Colors.black),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o Tópico Luz';
                }
                return null;
              },
              onSaved: (value) {
                topicoLu = value!;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: TextFormField(
              decoration: inputDecoration.copyWith(
                  hintText: "Tópico Luz Off/On",
                  labelText: "Tópico  Luz Off/On"),
              style: const TextStyle(color: Colors.black),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o Tópico Luz Off/On';
                }
                return null;
              },
              onSaved: (value) {
                topicoLuOffOn = value!;
              },
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: submitForm,
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }

  Widget getTemperatura() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: SfRadialGauge(
        title: GaugeTitle(
            text: 'Temperatura',
            backgroundColor: temperatura < 40
                ? Colors.green
                : temperatura >= 40 && temperatura < 80
                    ? Colors.yellow
                    : Colors.red,
            textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontFamily: 'Times'),
            borderColor: Colors.indigo,
            alignment: GaugeAlignment.center),
        axes: [
          RadialAxis(
            minimum: 0,
            maximum: 100,
            ranges: [
              GaugeRange(
                  startValue: 0,
                  endValue: 40,
                  color: Colors.green,
                  startWidth: 10,
                  endWidth: 10),
              GaugeRange(
                  startValue: 40,
                  endValue: 80,
                  color: Colors.orange,
                  startWidth: 10,
                  endWidth: 10),
              GaugeRange(
                  startValue: 80,
                  endValue: 100,
                  color: Colors.red,
                  startWidth: 10,
                  endWidth: 10)
            ],
            pointers: [
              NeedlePointer(value: temperatura),
            ],
            annotations: [
              GaugeAnnotation(
                  widget: Text(
                    '$temperatura',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  angle: 90,
                  positionFactor: 0.5)
            ],
          )
        ],
      ),
    );
  }

  Widget getLuminosidade() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SfLinearGauge(
        maximum: 1000,
        ranges: const [
          LinearGaugeRange(startValue: 0, endValue: 300, color: Colors.green),
          LinearGaugeRange(
              startValue: 300, endValue: 600, color: Colors.lightBlue),
          LinearGaugeRange(startValue: 600, endValue: 1000, color: Colors.red)
        ],
        markerPointers: [
          LinearWidgetPointer(
            value: luminosidade,
            child: Container(
                height: 20,
                width: 5,
                decoration: const BoxDecoration(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget getBotao() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Switch(
          value: luz,
          activeColor: const Color.fromARGB(255, 0, 0, 0),
          onChanged: (bool value) {
            setState(
              () {
                try {
                  final builder = MqttClientPayloadBuilder();
                  builder.addString((value ? 1 : 0).toString());
                  client.publishMessage(
                      topicoLuOffOn, MqttQos.exactlyOnce, builder.payload!);
                  luz = value;
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                            "Problemas ao enviar no topico $topicoLuOffOn"),
                      );
                    },
                  );
                }
              },
            );
          },
        ),
        Icon(Icons.light_mode, color: luz ? Colors.yellow : Colors.black),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      conectIOT(host: host);
    }
  }
}
