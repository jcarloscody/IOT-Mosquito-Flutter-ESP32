package org.example;

import org.eclipse.paho.client.mqttv3.*;

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
    }
}

