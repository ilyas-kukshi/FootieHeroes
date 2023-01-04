// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_team_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AddTeamModel _$AddTeamModelFromJson(Map<String, dynamic> json) {
  return _AddTeamModel.fromJson(json);
}

/// @nodoc
mixin _$AddTeamModel {
  String? get id => throw _privateConstructorUsedError;
  String? get logoUri => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get townName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddTeamModelCopyWith<AddTeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddTeamModelCopyWith<$Res> {
  factory $AddTeamModelCopyWith(
          AddTeamModel value, $Res Function(AddTeamModel) then) =
      _$AddTeamModelCopyWithImpl<$Res, AddTeamModel>;
  @useResult
  $Res call({String? id, String? logoUri, String name, String townName});
}

/// @nodoc
class _$AddTeamModelCopyWithImpl<$Res, $Val extends AddTeamModel>
    implements $AddTeamModelCopyWith<$Res> {
  _$AddTeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? logoUri = freezed,
    Object? name = null,
    Object? townName = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUri: freezed == logoUri
          ? _value.logoUri
          : logoUri // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      townName: null == townName
          ? _value.townName
          : townName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddTeamModelCopyWith<$Res>
    implements $AddTeamModelCopyWith<$Res> {
  factory _$$_AddTeamModelCopyWith(
          _$_AddTeamModel value, $Res Function(_$_AddTeamModel) then) =
      __$$_AddTeamModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? logoUri, String name, String townName});
}

/// @nodoc
class __$$_AddTeamModelCopyWithImpl<$Res>
    extends _$AddTeamModelCopyWithImpl<$Res, _$_AddTeamModel>
    implements _$$_AddTeamModelCopyWith<$Res> {
  __$$_AddTeamModelCopyWithImpl(
      _$_AddTeamModel _value, $Res Function(_$_AddTeamModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? logoUri = freezed,
    Object? name = null,
    Object? townName = null,
  }) {
    return _then(_$_AddTeamModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUri: freezed == logoUri
          ? _value.logoUri
          : logoUri // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      townName: null == townName
          ? _value.townName
          : townName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AddTeamModel extends _AddTeamModel {
  _$_AddTeamModel(
      {this.id, this.logoUri, required this.name, required this.townName})
      : super._();

  factory _$_AddTeamModel.fromJson(Map<String, dynamic> json) =>
      _$$_AddTeamModelFromJson(json);

  @override
  final String? id;
  @override
  final String? logoUri;
  @override
  final String name;
  @override
  final String townName;

  @override
  String toString() {
    return 'AddTeamModel(id: $id, logoUri: $logoUri, name: $name, townName: $townName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddTeamModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.logoUri, logoUri) || other.logoUri == logoUri) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.townName, townName) ||
                other.townName == townName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, logoUri, name, townName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddTeamModelCopyWith<_$_AddTeamModel> get copyWith =>
      __$$_AddTeamModelCopyWithImpl<_$_AddTeamModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AddTeamModelToJson(
      this,
    );
  }
}

abstract class _AddTeamModel extends AddTeamModel {
  factory _AddTeamModel(
      {final String? id,
      final String? logoUri,
      required final String name,
      required final String townName}) = _$_AddTeamModel;
  _AddTeamModel._() : super._();

  factory _AddTeamModel.fromJson(Map<String, dynamic> json) =
      _$_AddTeamModel.fromJson;

  @override
  String? get id;
  @override
  String? get logoUri;
  @override
  String get name;
  @override
  String get townName;
  @override
  @JsonKey(ignore: true)
  _$$_AddTeamModelCopyWith<_$_AddTeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}
