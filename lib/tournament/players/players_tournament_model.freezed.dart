// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'players_tournament_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlayersTournamentModel _$PlayersTournamentModelFromJson(
    Map<String, dynamic> json) {
  return _PlayersTournamentModel.fromJson(json);
}

/// @nodoc
mixin _$PlayersTournamentModel {
  String? get id => throw _privateConstructorUsedError;
  AddTeamModel get teamModel => throw _privateConstructorUsedError;
  PlayerPersonalInfo get playerPersonalInfo =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayersTournamentModelCopyWith<PlayersTournamentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayersTournamentModelCopyWith<$Res> {
  factory $PlayersTournamentModelCopyWith(PlayersTournamentModel value,
          $Res Function(PlayersTournamentModel) then) =
      _$PlayersTournamentModelCopyWithImpl<$Res, PlayersTournamentModel>;
  @useResult
  $Res call(
      {String? id,
      AddTeamModel teamModel,
      PlayerPersonalInfo playerPersonalInfo});

  $AddTeamModelCopyWith<$Res> get teamModel;
  $PlayerPersonalInfoCopyWith<$Res> get playerPersonalInfo;
}

/// @nodoc
class _$PlayersTournamentModelCopyWithImpl<$Res,
        $Val extends PlayersTournamentModel>
    implements $PlayersTournamentModelCopyWith<$Res> {
  _$PlayersTournamentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? teamModel = null,
    Object? playerPersonalInfo = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      teamModel: null == teamModel
          ? _value.teamModel
          : teamModel // ignore: cast_nullable_to_non_nullable
              as AddTeamModel,
      playerPersonalInfo: null == playerPersonalInfo
          ? _value.playerPersonalInfo
          : playerPersonalInfo // ignore: cast_nullable_to_non_nullable
              as PlayerPersonalInfo,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AddTeamModelCopyWith<$Res> get teamModel {
    return $AddTeamModelCopyWith<$Res>(_value.teamModel, (value) {
      return _then(_value.copyWith(teamModel: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerPersonalInfoCopyWith<$Res> get playerPersonalInfo {
    return $PlayerPersonalInfoCopyWith<$Res>(_value.playerPersonalInfo,
        (value) {
      return _then(_value.copyWith(playerPersonalInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PlayersTournamentModelCopyWith<$Res>
    implements $PlayersTournamentModelCopyWith<$Res> {
  factory _$$_PlayersTournamentModelCopyWith(_$_PlayersTournamentModel value,
          $Res Function(_$_PlayersTournamentModel) then) =
      __$$_PlayersTournamentModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      AddTeamModel teamModel,
      PlayerPersonalInfo playerPersonalInfo});

  @override
  $AddTeamModelCopyWith<$Res> get teamModel;
  @override
  $PlayerPersonalInfoCopyWith<$Res> get playerPersonalInfo;
}

/// @nodoc
class __$$_PlayersTournamentModelCopyWithImpl<$Res>
    extends _$PlayersTournamentModelCopyWithImpl<$Res,
        _$_PlayersTournamentModel>
    implements _$$_PlayersTournamentModelCopyWith<$Res> {
  __$$_PlayersTournamentModelCopyWithImpl(_$_PlayersTournamentModel _value,
      $Res Function(_$_PlayersTournamentModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? teamModel = null,
    Object? playerPersonalInfo = null,
  }) {
    return _then(_$_PlayersTournamentModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      teamModel: null == teamModel
          ? _value.teamModel
          : teamModel // ignore: cast_nullable_to_non_nullable
              as AddTeamModel,
      playerPersonalInfo: null == playerPersonalInfo
          ? _value.playerPersonalInfo
          : playerPersonalInfo // ignore: cast_nullable_to_non_nullable
              as PlayerPersonalInfo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlayersTournamentModel extends _PlayersTournamentModel {
  _$_PlayersTournamentModel(
      {this.id, required this.teamModel, required this.playerPersonalInfo})
      : super._();

  factory _$_PlayersTournamentModel.fromJson(Map<String, dynamic> json) =>
      _$$_PlayersTournamentModelFromJson(json);

  @override
  final String? id;
  @override
  final AddTeamModel teamModel;
  @override
  final PlayerPersonalInfo playerPersonalInfo;

  @override
  String toString() {
    return 'PlayersTournamentModel(id: $id, teamModel: $teamModel, playerPersonalInfo: $playerPersonalInfo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlayersTournamentModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.teamModel, teamModel) ||
                other.teamModel == teamModel) &&
            (identical(other.playerPersonalInfo, playerPersonalInfo) ||
                other.playerPersonalInfo == playerPersonalInfo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, teamModel, playerPersonalInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlayersTournamentModelCopyWith<_$_PlayersTournamentModel> get copyWith =>
      __$$_PlayersTournamentModelCopyWithImpl<_$_PlayersTournamentModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlayersTournamentModelToJson(
      this,
    );
  }
}

abstract class _PlayersTournamentModel extends PlayersTournamentModel {
  factory _PlayersTournamentModel(
          {final String? id,
          required final AddTeamModel teamModel,
          required final PlayerPersonalInfo playerPersonalInfo}) =
      _$_PlayersTournamentModel;
  _PlayersTournamentModel._() : super._();

  factory _PlayersTournamentModel.fromJson(Map<String, dynamic> json) =
      _$_PlayersTournamentModel.fromJson;

  @override
  String? get id;
  @override
  AddTeamModel get teamModel;
  @override
  PlayerPersonalInfo get playerPersonalInfo;
  @override
  @JsonKey(ignore: true)
  _$$_PlayersTournamentModelCopyWith<_$_PlayersTournamentModel> get copyWith =>
      throw _privateConstructorUsedError;
}
