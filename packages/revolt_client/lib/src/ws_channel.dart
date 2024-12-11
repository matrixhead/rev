import 'dart:convert';

import 'package:revolt_client/src/api_wrapper/helpers.dart';
import 'package:revolt_client/src/config/config.dart';
import 'package:revolt_client/src/models/ws_events/ws_events.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WsChannel {

  WsChannel({required RevConfig config, WebSocketChannel? channel})
      : channel = channel ??
            WebSocketChannel.connect(
              Uri.parse('ws://${config.baseUrl}:${config.wsPort}'),
            );
            
  final WebSocketChannel channel;

  Future<void> get isReady => channel.ready;

  Stream<ServerToClientEvents> get stream =>
      channel.stream.map<ServerToClientEvents>(
        (event) =>
            ServerToClientEvents.fromJson(parseJsonToMap(event as String)),
      );

  void authenticateWsChannel(String sessionToken) {
    final json = jsonEncode(AuthenticateEvent(token: sessionToken).toJson());
    channel.sink.add(json);
  }
}
