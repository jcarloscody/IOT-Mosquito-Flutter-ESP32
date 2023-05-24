package org.example;

import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;

public class MQTTServer {
    private static final String BROKER = "tcp://localhost:1883";
    private static final String TOPIC = "temperatura";

    public static void main(String[] args) {
        try {
            // Criação do cliente MQTT
            MqttClient mqttClient = new MqttClient(BROKER, MqttClient.generateClientId());
            mqttClient.connect();

           while (true){
               // Publicação do tópico "temperatura"
               String message = "25.5"; // Valor da temperatura
               MqttMessage mqttMessage = new MqttMessage(message.getBytes());
               mqttClient.publish(TOPIC, mqttMessage);
               Thread.sleep(10000);
           }

            // Desconexão do cliente MQTT
          //  mqttClient.disconnect();
        } catch (MqttException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }
}

