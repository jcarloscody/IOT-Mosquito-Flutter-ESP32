package org.example;

import com.hivemq.client.mqtt.mqtt5.Mqtt5BlockingClient;
import org.eclipse.paho.client.mqttv3.*;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;

import static java.nio.charset.StandardCharsets.UTF_8;

public class MQTTSubscriber {
    private static final String BROKER = "tcp://localhost:1883";
    private static final String TOPIC = "temperatura";

    public static void main(String[] args) {
        try {
            // Criação do cliente MQTT
            MqttClient mqttClient = new MqttClient(BROKER, MqttClient.generateClientId());

            // Definição do callback para receber as mensagens
            mqttClient.setCallback(new MqttCallback() {
                @Override
                public void connectionLost(Throwable throwable) {

                }

                @Override
                public void messageArrived(String topic, MqttMessage message) throws Exception {
                    // Recebimento da mensagem
                    System.out.println("Tópico: " + topic);
                    System.out.println("Mensagem: " + new String(message.getPayload()));

                }

                @Override
                public void deliveryComplete(IMqttDeliveryToken iMqttDeliveryToken) {

                }
            });

            // Conexão ao broker MQTT
            mqttClient.connect();

            // Inscrição no tópico "temperatura"
            mqttClient.subscribe(TOPIC);
        } catch (MqttException e) {
            e.printStackTrace();
        }

       /* final String host = "fe65a26d8a524e6e9f90780d2307503b.s2.eu.hivemq.cloud";
        final String username = "josue";
        final String password = "<your_password>";

        // create an MQTT client
        final Mqtt5BlockingClient client = MqttClient.builder()
                .useMqttVersion5()
                .serverHost(host)
                .serverPort(8883)
                .sslWithDefaultConfig()
                .buildBlocking();

        // connect to HiveMQ Cloud with TLS and username/pw
        client.connectWith()
                .simpleAuth()
                .username(username)
                .password(UTF_8.encode(password))
                .applySimpleAuth()
                .send();

        System.out.println("Connected successfully");

        // subscribe to the topic "my/test/topic"
        client.subscribeWith()
                .topicFilter("my/test/topic")
                .send();

        // set a callback that is called when a message is received (using the async API style)
        client.toAsync().publishes(ALL, publish -> {
            System.out.println("Received message: " +
                    publish.getTopic() + " -> " +
                    UTF_8.decode(publish.getPayload().get()));

            // disconnect the client after a message was received
            client.disconnect();
        });

        // publish a message to the topic "my/test/topic"
        client.publishWith()
                .topic("my/test/topic")
                .payload(UTF_8.encode("Hello"))
                .send();

        /*final String broker = "tcp://fe65a26d8a524e6e9f90780d2307503b.s2.eu.hivemq.cloud";
        final String clientId = "ExampleClient";
        final String topic = "temperatura";
        final String username = "josue";
        final String password = "123456789";

        try {
            MqttClient client = new MqttClient(broker, clientId, new MemoryPersistence());

            // Set MQTT options
            MqttConnectOptions options = new MqttConnectOptions();
            options.setUserName(username);
            options.setPassword(password.toCharArray());

            // Connect to the MQTT broker
            client.connect(options);
            System.out.println("Connected successfully");

            // Subscribe to the topic
            client.subscribe(topic);

            // Set up message callback
            client.setCallback(new MqttCallback() {
                @Override
                public void connectionLost(Throwable cause) {
                    System.out.println("Connection lost");
                }

                @Override
                public void messageArrived(String topic, MqttMessage message) throws Exception {
                    System.out.println("Received message: " + new String(message.getPayload()));
                }

                @Override
                public void deliveryComplete(IMqttDeliveryToken token) {
                }
            });

           /* while (true){
                // Publish a message
                String message = "Hello";
                client.publish(topic, message.getBytes(), 0, false);
                System.out.println("Message published");
                Thread.sleep(5000);
            }*/

            // Disconnect from the MQTT broker
          //  client.disconnect();
            //System.out.println("Disconnected");
      /*  } catch (MqttException e) {
            e.printStackTrace();
        }*/


    }
}

