import 'dart:convert';

import 'package:revolt_client/src/config/config.dart';
import 'package:revolt_client/src/models/ws_events/ws_events.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WsChannel {
  final WebSocketChannel channel;

  WsChannel({WebSocketChannel? channel, required RevConfig config})
      : channel = channel ??
            WebSocketChannel.connect(
                Uri.parse("ws://${config.baseUrl}:${config.wsPort}"));

  get isReady=> channel.ready;
  
  Stream<ServerToClientEvents> get stream => channel.stream.map<ServerToClientEvents>(( event ) => ServerToClientEvents.fromJson(jsonDecode(event)) );

  authenticateWsChannel(String sessionToken) {
    
final json = jsonEncode( AuthenticateEvent(token: sessionToken).toJson());
    channel.sink.add(json);
    
  }
}
