// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_personal_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlayerPersonalInfo _$PlayerPersonalInfoFromJson(Map<String, dynamic> json) {
  return _PlayerPersonalInfo.fromJson(json);
}

/// @nodoc
mixin _$PlayerPersonalInfo {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phoneNo => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get prefFoot => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String? get photoUri => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerPersonalInfoCopyWith<PlayerPersonalInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerPersonalInfoCopyWith<$Res> {
  factory $PlayerPersonalInfoCopyWith(
          PlayerPersonalInfo value, $Res Function(PlayerPersonalInfo) then) =
      _$PlayerPersonalInfoCopyWithImpl<$Res, PlayerPersonalInfo>;
  @useResult
  $Res call(
      {String? id,
      String name,
      String phoneNo,
      String position,
      String role,
      String prefFoot,
      String gender,
      String? photoUri});
}

/// @nodoc
class _$PlayerPersonalInfoCopyWithImpl<$Res, $Val extends PlayerPersonalInfo>
    implements $PlayerPersonalInfoCopyWith<$Res> {
  _$PlayerPersonalInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? phoneNo = null,
    Object? position = null,
    Object? role = null,
    Object? prefFoot = null,
    Object? gender = null,
    Object? photoUri = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNo: null == phoneNo
          ? _value.phoneNo
          : phoneNo // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      prefFoot: null == prefFoot
          ? _value.prefFoot
          : prefFoot // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      photoUri: freezed == photoUri
          ? _value.photoUri
          : photoUri // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlayerPersonalInfoCopyWith<$Res>
    implements $PlayerPersonalInfoCopyWith<$Res> {
  factory _$$_PlayerPersonalInfoCopyWith(_$_PlayerPersonalInfo value,
          $Res Function(_$_PlayerPersonalInfo) then) =
      __$$_PlayerPersonalInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String name,
      String phoneNo,
      String position,
      String role,
      String prefFoot,
      String gender,
      String? photoUri});
}

/// @nodoc
class __$$_PlayerPersonalInfoCopyWithImpl<$Res>
    extends _$PlayerPersonalInfoCopyWithImpl<$Res, _$_PlayerPersonalInfo>
    implements _$$_PlayerPersonalInfoCopyWith<$Res> {
  __$$_PlayerPersonalInfoCopyWithImpl(
      _$_PlayerPersonalInfo _value, $Res Function(_$_PlayerPersonalInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? phoneNo = null,
    Object? position = null,
    Object? role = null,
    Object? prefFoot = null,
    Object? gender = null,
    Object? photoUri = freezed,
  }) {
    return _then(_$_PlayerPersonalInfo(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNo: null == phoneNo
          ? _value.phoneNo
          : phoneNo // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      prefFoot: null == prefFoot
          ? _value.prefFoot
          : prefFoot // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      photoUri: freezed == photoUri
          ? _value.photoUri
          : photoUri // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlayerPersonalInfo extends _PlayerPersonalInfo {
  _$_PlayerPersonalInfo(
      {this.id,
      required this.name,
      required this.phoneNo,
      required this.position,
      required this.role,
      required this.prefFoot,
      required this.gender,
      this.photoUri})
      : super._();

  factory _$_PlayerPersonalInfo.fromJson(Map<String, dynamic> json) =>
      _$$_PlayerPersonalInfoFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String phoneNo;
  @override
  final String position;
  @override
  final String role;
  @override
  final String prefFoot;
  @override
  final String gender;
  @override
  final String? photoUri;

  @override
  String toString() {
    return 'PlayerPersonalInfo(id: $id, name: $name, phoneNo: $phoneNo, position: $position, role: $role, prefFoot: $prefFoot, gender: $gender, photoUri: $photoUri)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlayerPersonalInfo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.prefFoot, prefFoot) ||
                other.prefFoot == prefFoot) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.photoUri, photoUri) ||
                other.photoUri == photoUri));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phoneNo, position,
      role, prefFoot, gender, photoUri);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlayerPersonalInfoCopyWith<_$_PlayerPersonalInfo> get copyWith =>
      __$$_PlayerPersonalInfoCopyWithImpl<_$_PlayerPersonalInfo>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlayerPersonalInfoToJson(
      this,
    );
  }
}

abstract class _PlayerPersonalInfo extends PlayerPersonalInfo {
  factory _PlayerPersonalInfo(
      {final String? id,
      required final String name,
      required final String phoneNo,
      required final String position,
      required final String role,
      required final String prefFoot,
      required final String gender,
      final String? photoUri}) = _$_PlayerPersonalInfo;
  _PlayerPersonalInfo._() : super._();

  factory _PlayerPersonalInfo.fromJson(Map<String, dynamic> json) =
      _$_PlayerPersonalInfo.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String get phoneNo;
  @override
  String get position;
  @override
  String get role;
  @override
  String get prefFoot;
  @override
  String get gender;
  @override
  String? get photoUri;
  @override
  @JsonKey(ignore: true)
  _$$_PlayerPersonalInfoCopyWith<_$_PlayerPersonalInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
