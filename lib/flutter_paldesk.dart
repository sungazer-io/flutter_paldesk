import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FlutterPaldesk {
  static const MethodChannel _channel =
      const MethodChannel('flutter_paldesk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> init({
    @required String apiKey,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'apiKey': apiKey
    };
    final bool result = await _channel.invokeMethod('init', params);
    return result;
  }

  static Future<bool> startConversation() async {
    final bool result = await _channel.invokeMethod('startConversation');
    return result;
  }

  static Future<bool> createClient({
    @required String email,
    @required String externalId,
    String firstName,
    String lastName
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'email': email,
      'externalId': externalId,
      'firstName': firstName,
      'lastName': lastName

    };
    final bool result = await _channel.invokeMethod('createClient', params);
    return result;
  }

  static Future<bool> createAnonymousClient() async {
    final bool result = await _channel.invokeMethod('createAnonymousClient');
    return result;
  }

  static Future<bool> clear() async {
    final bool result = await _channel.invokeMethod('clear');
    return result;
  }
}
