import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider {
  
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _messageStreamController = StreamController<String>.broadcast();
  Stream<String> get messagesStream => _messageStreamController.stream;

  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

  // Or do other work.
  }
  initNotificactions() async {
    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();
    print('==== firebase token ====');
    print(token);

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print('==== onMessage ====');
    final argument = message['data']['food'] ?? 'no-data';
    _messageStreamController.sink.add(argument);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print('==== onLaunch ====');
    final argument = message['data']['food'] ?? 'no-data';
    _messageStreamController.sink.add(argument);
    
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print('==== onResume ====');
    final argument = message['data']['food'] ?? 'no-data';
    _messageStreamController.sink.add(argument);
  }

  dispose(){
    _messageStreamController?.close();
  }


}

  
