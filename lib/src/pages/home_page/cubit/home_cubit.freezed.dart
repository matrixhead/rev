// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  Map<String, RelationUser> get friendsList =>
      throw _privateConstructorUsedError;
  PageState get page => throw _privateConstructorUsedError;
  String? get currentSelectedChannel => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {Map<String, RelationUser> friendsList,
      PageState page,
      String? currentSelectedChannel});

  $PageStateCopyWith<$Res> get page;
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friendsList = null,
    Object? page = null,
    Object? currentSelectedChannel = freezed,
  }) {
    return _then(_value.copyWith(
      friendsList: null == friendsList
          ? _value.friendsList
          : friendsList // ignore: cast_nullable_to_non_nullable
              as Map<String, RelationUser>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as PageState,
      currentSelectedChannel: freezed == currentSelectedChannel
          ? _value.currentSelectedChannel
          : currentSelectedChannel // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get page {
    return $PageStateCopyWith<$Res>(_value.page, (value) {
      return _then(_value.copyWith(page: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, RelationUser> friendsList,
      PageState page,
      String? currentSelectedChannel});

  @override
  $PageStateCopyWith<$Res> get page;
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friendsList = null,
    Object? page = null,
    Object? currentSelectedChannel = freezed,
  }) {
    return _then(_$HomeStateImpl(
      null == friendsList
          ? _value._friendsList
          : friendsList // ignore: cast_nullable_to_non_nullable
              as Map<String, RelationUser>,
      null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as PageState,
      freezed == currentSelectedChannel
          ? _value.currentSelectedChannel
          : currentSelectedChannel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl extends _HomeState {
  const _$HomeStateImpl(
      [final Map<String, RelationUser> friendsList = const {},
      this.page = const PageState.withOutAnimation(0),
      this.currentSelectedChannel])
      : _friendsList = friendsList,
        super._();

  final Map<String, RelationUser> _friendsList;
  @override
  @JsonKey()
  Map<String, RelationUser> get friendsList {
    if (_friendsList is EqualUnmodifiableMapView) return _friendsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_friendsList);
  }

  @override
  @JsonKey()
  final PageState page;
  @override
  final String? currentSelectedChannel;

  @override
  String toString() {
    return 'HomeState(friendsList: $friendsList, page: $page, currentSelectedChannel: $currentSelectedChannel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            const DeepCollectionEquality()
                .equals(other._friendsList, _friendsList) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.currentSelectedChannel, currentSelectedChannel) ||
                other.currentSelectedChannel == currentSelectedChannel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_friendsList),
      page,
      currentSelectedChannel);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState extends HomeState {
  const factory _HomeState(
      [final Map<String, RelationUser> friendsList,
      final PageState page,
      final String? currentSelectedChannel]) = _$HomeStateImpl;
  const _HomeState._() : super._();

  @override
  Map<String, RelationUser> get friendsList;
  @override
  PageState get page;
  @override
  String? get currentSelectedChannel;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PageState {
  int get pageNumber => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int pageNumber) withAnimation,
    required TResult Function(int pageNumber) withOutAnimation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int pageNumber)? withAnimation,
    TResult? Function(int pageNumber)? withOutAnimation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int pageNumber)? withAnimation,
    TResult Function(int pageNumber)? withOutAnimation,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageStateWithAnimation value) withAnimation,
    required TResult Function(PageStateWithOutAnimation value) withOutAnimation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageStateWithAnimation value)? withAnimation,
    TResult? Function(PageStateWithOutAnimation value)? withOutAnimation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageStateWithAnimation value)? withAnimation,
    TResult Function(PageStateWithOutAnimation value)? withOutAnimation,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of PageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PageStateCopyWith<PageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageStateCopyWith<$Res> {
  factory $PageStateCopyWith(PageState value, $Res Function(PageState) then) =
      _$PageStateCopyWithImpl<$Res, PageState>;
  @useResult
  $Res call({int pageNumber});
}

/// @nodoc
class _$PageStateCopyWithImpl<$Res, $Val extends PageState>
    implements $PageStateCopyWith<$Res> {
  _$PageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageNumber = null,
  }) {
    return _then(_value.copyWith(
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PageStateWithAnimationImplCopyWith<$Res>
    implements $PageStateCopyWith<$Res> {
  factory _$$PageStateWithAnimationImplCopyWith(
          _$PageStateWithAnimationImpl value,
          $Res Function(_$PageStateWithAnimationImpl) then) =
      __$$PageStateWithAnimationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int pageNumber});
}

/// @nodoc
class __$$PageStateWithAnimationImplCopyWithImpl<$Res>
    extends _$PageStateCopyWithImpl<$Res, _$PageStateWithAnimationImpl>
    implements _$$PageStateWithAnimationImplCopyWith<$Res> {
  __$$PageStateWithAnimationImplCopyWithImpl(
      _$PageStateWithAnimationImpl _value,
      $Res Function(_$PageStateWithAnimationImpl) _then)
      : super(_value, _then);

  /// Create a copy of PageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageNumber = null,
  }) {
    return _then(_$PageStateWithAnimationImpl(
      null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PageStateWithAnimationImpl implements PageStateWithAnimation {
  const _$PageStateWithAnimationImpl(this.pageNumber);

  @override
  final int pageNumber;

  @override
  String toString() {
    return 'PageState.withAnimation(pageNumber: $pageNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageStateWithAnimationImpl &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pageNumber);

  /// Create a copy of PageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PageStateWithAnimationImplCopyWith<_$PageStateWithAnimationImpl>
      get copyWith => __$$PageStateWithAnimationImplCopyWithImpl<
          _$PageStateWithAnimationImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int pageNumber) withAnimation,
    required TResult Function(int pageNumber) withOutAnimation,
  }) {
    return withAnimation(pageNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int pageNumber)? withAnimation,
    TResult? Function(int pageNumber)? withOutAnimation,
  }) {
    return withAnimation?.call(pageNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int pageNumber)? withAnimation,
    TResult Function(int pageNumber)? withOutAnimation,
    required TResult orElse(),
  }) {
    if (withAnimation != null) {
      return withAnimation(pageNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageStateWithAnimation value) withAnimation,
    required TResult Function(PageStateWithOutAnimation value) withOutAnimation,
  }) {
    return withAnimation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageStateWithAnimation value)? withAnimation,
    TResult? Function(PageStateWithOutAnimation value)? withOutAnimation,
  }) {
    return withAnimation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageStateWithAnimation value)? withAnimation,
    TResult Function(PageStateWithOutAnimation value)? withOutAnimation,
    required TResult orElse(),
  }) {
    if (withAnimation != null) {
      return withAnimation(this);
    }
    return orElse();
  }
}

abstract class PageStateWithAnimation implements PageState {
  const factory PageStateWithAnimation(final int pageNumber) =
      _$PageStateWithAnimationImpl;

  @override
  int get pageNumber;

  /// Create a copy of PageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PageStateWithAnimationImplCopyWith<_$PageStateWithAnimationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PageStateWithOutAnimationImplCopyWith<$Res>
    implements $PageStateCopyWith<$Res> {
  factory _$$PageStateWithOutAnimationImplCopyWith(
          _$PageStateWithOutAnimationImpl value,
          $Res Function(_$PageStateWithOutAnimationImpl) then) =
      __$$PageStateWithOutAnimationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int pageNumber});
}

/// @nodoc
class __$$PageStateWithOutAnimationImplCopyWithImpl<$Res>
    extends _$PageStateCopyWithImpl<$Res, _$PageStateWithOutAnimationImpl>
    implements _$$PageStateWithOutAnimationImplCopyWith<$Res> {
  __$$PageStateWithOutAnimationImplCopyWithImpl(
      _$PageStateWithOutAnimationImpl _value,
      $Res Function(_$PageStateWithOutAnimationImpl) _then)
      : super(_value, _then);

  /// Create a copy of PageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageNumber = null,
  }) {
    return _then(_$PageStateWithOutAnimationImpl(
      null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PageStateWithOutAnimationImpl implements PageStateWithOutAnimation {
  const _$PageStateWithOutAnimationImpl(this.pageNumber);

  @override
  final int pageNumber;

  @override
  String toString() {
    return 'PageState.withOutAnimation(pageNumber: $pageNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageStateWithOutAnimationImpl &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pageNumber);

  /// Create a copy of PageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PageStateWithOutAnimationImplCopyWith<_$PageStateWithOutAnimationImpl>
      get copyWith => __$$PageStateWithOutAnimationImplCopyWithImpl<
          _$PageStateWithOutAnimationImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int pageNumber) withAnimation,
    required TResult Function(int pageNumber) withOutAnimation,
  }) {
    return withOutAnimation(pageNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int pageNumber)? withAnimation,
    TResult? Function(int pageNumber)? withOutAnimation,
  }) {
    return withOutAnimation?.call(pageNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int pageNumber)? withAnimation,
    TResult Function(int pageNumber)? withOutAnimation,
    required TResult orElse(),
  }) {
    if (withOutAnimation != null) {
      return withOutAnimation(pageNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageStateWithAnimation value) withAnimation,
    required TResult Function(PageStateWithOutAnimation value) withOutAnimation,
  }) {
    return withOutAnimation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageStateWithAnimation value)? withAnimation,
    TResult? Function(PageStateWithOutAnimation value)? withOutAnimation,
  }) {
    return withOutAnimation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageStateWithAnimation value)? withAnimation,
    TResult Function(PageStateWithOutAnimation value)? withOutAnimation,
    required TResult orElse(),
  }) {
    if (withOutAnimation != null) {
      return withOutAnimation(this);
    }
    return orElse();
  }
}

abstract class PageStateWithOutAnimation implements PageState {
  const factory PageStateWithOutAnimation(final int pageNumber) =
      _$PageStateWithOutAnimationImpl;

  @override
  int get pageNumber;

  /// Create a copy of PageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PageStateWithOutAnimationImplCopyWith<_$PageStateWithOutAnimationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
