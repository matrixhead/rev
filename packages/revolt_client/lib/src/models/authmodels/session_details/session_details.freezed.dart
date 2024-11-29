// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionDetails _$SessionDetailsFromJson(Map<String, dynamic> json) {
  return _SessionDetails.fromJson(json);
}

/// @nodoc
mixin _$SessionDetails {
  @JsonKey(name: "_id")
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: "user_id")
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: "token")
  String get sessionToken => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String get deviceName => throw _privateConstructorUsedError;
  @JsonKey(name: "subscription")
  String? get webPushSubscription => throw _privateConstructorUsedError;

  /// Serializes this SessionDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionDetailsCopyWith<SessionDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionDetailsCopyWith<$Res> {
  factory $SessionDetailsCopyWith(
          SessionDetails value, $Res Function(SessionDetails) then) =
      _$SessionDetailsCopyWithImpl<$Res, SessionDetails>;
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String id,
      @JsonKey(name: "user_id") String userId,
      @JsonKey(name: "token") String sessionToken,
      @JsonKey(name: "name") String deviceName,
      @JsonKey(name: "subscription") String? webPushSubscription});
}

/// @nodoc
class _$SessionDetailsCopyWithImpl<$Res, $Val extends SessionDetails>
    implements $SessionDetailsCopyWith<$Res> {
  _$SessionDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? sessionToken = null,
    Object? deviceName = null,
    Object? webPushSubscription = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      sessionToken: null == sessionToken
          ? _value.sessionToken
          : sessionToken // ignore: cast_nullable_to_non_nullable
              as String,
      deviceName: null == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String,
      webPushSubscription: freezed == webPushSubscription
          ? _value.webPushSubscription
          : webPushSubscription // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionDetailsImplCopyWith<$Res>
    implements $SessionDetailsCopyWith<$Res> {
  factory _$$SessionDetailsImplCopyWith(_$SessionDetailsImpl value,
          $Res Function(_$SessionDetailsImpl) then) =
      __$$SessionDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String id,
      @JsonKey(name: "user_id") String userId,
      @JsonKey(name: "token") String sessionToken,
      @JsonKey(name: "name") String deviceName,
      @JsonKey(name: "subscription") String? webPushSubscription});
}

/// @nodoc
class __$$SessionDetailsImplCopyWithImpl<$Res>
    extends _$SessionDetailsCopyWithImpl<$Res, _$SessionDetailsImpl>
    implements _$$SessionDetailsImplCopyWith<$Res> {
  __$$SessionDetailsImplCopyWithImpl(
      _$SessionDetailsImpl _value, $Res Function(_$SessionDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? sessionToken = null,
    Object? deviceName = null,
    Object? webPushSubscription = freezed,
  }) {
    return _then(_$SessionDetailsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      sessionToken: null == sessionToken
          ? _value.sessionToken
          : sessionToken // ignore: cast_nullable_to_non_nullable
              as String,
      deviceName: null == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String,
      webPushSubscription: freezed == webPushSubscription
          ? _value.webPushSubscription
          : webPushSubscription // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionDetailsImpl implements _SessionDetails {
  const _$SessionDetailsImpl(
      {@JsonKey(name: "_id") required this.id,
      @JsonKey(name: "user_id") required this.userId,
      @JsonKey(name: "token") required this.sessionToken,
      @JsonKey(name: "name") required this.deviceName,
      @JsonKey(name: "subscription") this.webPushSubscription});

  factory _$SessionDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionDetailsImplFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String id;
  @override
  @JsonKey(name: "user_id")
  final String userId;
  @override
  @JsonKey(name: "token")
  final String sessionToken;
  @override
  @JsonKey(name: "name")
  final String deviceName;
  @override
  @JsonKey(name: "subscription")
  final String? webPushSubscription;

  @override
  String toString() {
    return 'SessionDetails(id: $id, userId: $userId, sessionToken: $sessionToken, deviceName: $deviceName, webPushSubscription: $webPushSubscription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionDetailsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.sessionToken, sessionToken) ||
                other.sessionToken == sessionToken) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.webPushSubscription, webPushSubscription) ||
                other.webPushSubscription == webPushSubscription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, sessionToken, deviceName, webPushSubscription);

  /// Create a copy of SessionDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionDetailsImplCopyWith<_$SessionDetailsImpl> get copyWith =>
      __$$SessionDetailsImplCopyWithImpl<_$SessionDetailsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionDetailsImplToJson(
      this,
    );
  }
}

abstract class _SessionDetails implements SessionDetails {
  const factory _SessionDetails(
          {@JsonKey(name: "_id") required final String id,
          @JsonKey(name: "user_id") required final String userId,
          @JsonKey(name: "token") required final String sessionToken,
          @JsonKey(name: "name") required final String deviceName,
          @JsonKey(name: "subscription") final String? webPushSubscription}) =
      _$SessionDetailsImpl;

  factory _SessionDetails.fromJson(Map<String, dynamic> json) =
      _$SessionDetailsImpl.fromJson;

  @override
  @JsonKey(name: "_id")
  String get id;
  @override
  @JsonKey(name: "user_id")
  String get userId;
  @override
  @JsonKey(name: "token")
  String get sessionToken;
  @override
  @JsonKey(name: "name")
  String get deviceName;
  @override
  @JsonKey(name: "subscription")
  String? get webPushSubscription;

  /// Create a copy of SessionDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionDetailsImplCopyWith<_$SessionDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
