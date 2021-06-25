import 'dart:convert';
import 'package:http/http.dart';

class Messaging {
  static final Client client = Client();

  static const String serverKey =
      'AAAAmJgknUI:APA91bFnCpLJK8ZwjLHIu2FcT1CemF6sC9iv5uL7xEu7ZliGiYduHEZfO-ggpEp_bBkBoS3W0iBPG58MTNzGh-QdOAGoSeggWR-Gz4MQrB85XeLQiQZj8ezN6WVRHZfkoOsGKa2HuX_a';

  static Future<Response> sendToAll({
    required String title,
    required String body,
  }) =>
      sendToTopic(title: title, body: body, topic: 'all');

  static Future<Response> sendToTopic(
          {required String title,
          required String body,
          required String topic}) =>
      sendTo(title: title, body: body, fcmToken: '/topics/$topic');

  static Future<Response> sendTo({
    required String title,
    required String body,
    required String fcmToken,
  }) =>
      client.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: json.encode({
          'notification': {'body': '$body', 'title': '$title'},
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'title': 'Title',
            'body': 'Body'
          },
          'to': '$fcmToken',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );
}
