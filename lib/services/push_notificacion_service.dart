//2B:19:D6:16:ED:5C:98:4C:16:09:DD:D2:B0:21:25:9E:C5:E8:16:A0

import 'package:country/helpers/preferencias_usuario.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class PushNotificationService { 

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String token;

  static void initNotifications(){

    messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

  }
  

  static Future<void> _opbackgroundHandler(RemoteMessage message) async {
    print('onBackground Handler ${ message.messageId }');
    // final provider = Provider.of<NotificacionesProvider>(context, listen: false);
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async {
    print('onMessage Handler ${ message.messageId }');
  }

  static Future<void> _onMessageOpenApp(RemoteMessage message) async {
    print('_onMessageOpenApp Handler ${ message.messageId }');
  }

  static Future initializeApp() async {

    // Push Notifications

    await Firebase.initializeApp();
    initNotifications();
    token = await FirebaseMessaging.instance.getToken();
    final prefs = PreferenciasUsuario();

    prefs.deviceToken = token;

    //Handlers
    // FirebaseMessaging.onBackgroundMessage((message) => null)
    FirebaseMessaging.onBackgroundMessage(_opbackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    // Local Notifications
  }

  Future<void> obtenerDeviceToken()async {
    token = await FirebaseMessaging.instance.getToken();
    print("desde el aca:" + token);
    final prefs = PreferenciasUsuario();

    prefs.deviceToken = token;
  }

}

//dEhZiCt-SN-mBtlfIfDc6w:APA91bElSgpX322MCDS7eHD6FEl9i1r4wFmpWoxPWPyXZTdGVvA_QpmhCWXaxGcmK_SPF4E_sU4PPVXJemS4-qXt8CKqBQvgD6K6Sfux3Q2wSg8cngkoQA7dQbgJsGxIyYWjF2LVO6b7