// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(EnrichedChannel channel) channelLoaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(EnrichedChannel channel)? channelLoaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(EnrichedChannel channel)? channelLoaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatStateInitial value) initial,
    required TResult Function(ChatStateChannelLoaded value) channelLoaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatStateInitial value)? initial,
    TResult? Function(ChatStateChannelLoaded value)? channelLoaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatStateInitial value)? initial,
    TResult Function(ChatStateChannelLoaded value)? channelLoaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res, ChatState>;
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res, $Val extends ChatState>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ChatStateInitialImplCopyWith<$Res> {
  factory _$$ChatStateInitialImplCopyWith(_$ChatStateInitialImpl value,
          $Res Function(_$ChatStateInitialImpl) then) =
      __$$ChatStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatStateInitialImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatStateInitialImpl>
    implements _$$ChatStateInitialImplCopyWith<$Res> {
  __$$ChatStateInitialImplCopyWithImpl(_$ChatStateInitialImpl _value,
      $Res Function(_$ChatStateInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChatStateInitialImpl implements ChatStateInitial {
  const _$ChatStateInitialImpl();

  @override
  String toString() {
    return 'ChatState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(EnrichedChannel channel) channelLoaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(EnrichedChannel channel)? channelLoaded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(EnrichedChannel channel)? channelLoaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatStateInitial value) initial,
    required TResult Function(ChatStateChannelLoaded value) channelLoaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatStateInitial value)? initial,
    TResult? Function(ChatStateChannelLoaded value)? channelLoaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatStateInitial value)? initial,
    TResult Function(ChatStateChannelLoaded value)? channelLoaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ChatStateInitial implements ChatState {
  const factory ChatStateInitial() = _$ChatStateInitialImpl;
}

/// @nodoc
abstract class _$$ChatStateChannelLoadedImplCopyWith<$Res> {
  factory _$$ChatStateChannelLoadedImplCopyWith(
          _$ChatStateChannelLoadedImpl value,
          $Res Function(_$ChatStateChannelLoadedImpl) then) =
      __$$ChatStateChannelLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({EnrichedChannel channel});
}

/// @nodoc
class __$$ChatStateChannelLoadedImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatStateChannelLoadedImpl>
    implements _$$ChatStateChannelLoadedImplCopyWith<$Res> {
  __$$ChatStateChannelLoadedImplCopyWithImpl(
      _$ChatStateChannelLoadedImpl _value,
      $Res Function(_$ChatStateChannelLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channel = null,
  }) {
    return _then(_$ChatStateChannelLoadedImpl(
      null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as EnrichedChannel,
    ));
  }
}

/// @nodoc

class _$ChatStateChannelLoadedImpl implements ChatStateChannelLoaded {
  const _$ChatStateChannelLoadedImpl(this.channel);

  @override
  final EnrichedChannel channel;

  @override
  String toString() {
    return 'ChatState.channelLoaded(channel: $channel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatStateChannelLoadedImpl &&
            (identical(other.channel, channel) || other.channel == channel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, channel);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatStateChannelLoadedImplCopyWith<_$ChatStateChannelLoadedImpl>
      get copyWith => __$$ChatStateChannelLoadedImplCopyWithImpl<
          _$ChatStateChannelLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(EnrichedChannel channel) channelLoaded,
  }) {
    return channelLoaded(channel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(EnrichedChannel channel)? channelLoaded,
  }) {
    return channelLoaded?.call(channel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(EnrichedChannel channel)? channelLoaded,
    required TResult orElse(),
  }) {
    if (channelLoaded != null) {
      return channelLoaded(channel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatStateInitial value) initial,
    required TResult Function(ChatStateChannelLoaded value) channelLoaded,
  }) {
    return channelLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatStateInitial value)? initial,
    TResult? Function(ChatStateChannelLoaded value)? channelLoaded,
  }) {
    return channelLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatStateInitial value)? initial,
    TResult Function(ChatStateChannelLoaded value)? channelLoaded,
    required TResult orElse(),
  }) {
    if (channelLoaded != null) {
      return channelLoaded(this);
    }
    return orElse();
  }
}

abstract class ChatStateChannelLoaded implements ChatState {
  const factory ChatStateChannelLoaded(final EnrichedChannel channel) =
      _$ChatStateChannelLoadedImpl;

  EnrichedChannel get channel;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatStateChannelLoadedImplCopyWith<_$ChatStateChannelLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
