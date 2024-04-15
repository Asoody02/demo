import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async{
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class NotifApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> sendNotif() async {
    await _firebaseMessaging.requestPermission();
    final fcmtoken = await _firebaseMessaging.getToken();
    print('Token: $fcmtoken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}