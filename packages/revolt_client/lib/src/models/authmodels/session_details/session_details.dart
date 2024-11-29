import 'package:freezed_annotation/freezed_annotation.dart';
part 'session_details.freezed.dart';
part 'session_details.g.dart';

@freezed
class SessionDetails with _$SessionDetails {
  const factory SessionDetails({
    @JsonKey(name: "_id") required String id,
    @JsonKey(name: "user_id") required String userId,
    @JsonKey(name: "token") required String sessionToken,
    @JsonKey(name: "name") required String deviceName,
    @JsonKey(name: "subscription") String? webPushSubscription,
  }) = _SessionDetails;
  factory SessionDetails.fromJson(Map<String, Object?> json) =>
      _$SessionDetailsFromJson(json);
}
