// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_match_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AddMatchModel _$AddMatchModelFromJson(Map<String, dynamic> json) {
  return _AddMatchModel.fromJson(json);
}

/// @nodoc
mixin _$AddMatchModel {
  String? get id => throw _privateConstructorUsedError;
  String get matchType => throw _privateConstructorUsedError;
  AddTeamModel get homeTeam => throw _privateConstructorUsedError;
  AddTeamModel get awayTeam => throw _privateConstructorUsedError;
  int get noOfHalfs => throw _privateConstructorUsedError;
  int get minsEachHalf => throw _privateConstructorUsedError;
  int get startingPlayers => throw _privateConstructorUsedError;
  int get noOfSubs => throw _privateConstructorUsedError;
  String get substitutionType => throw _privateConstructorUsedError;
  DateTime get matchDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddMatchModelCopyWith<AddMatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddMatchModelCopyWith<$Res> {
  factory $AddMatchModelCopyWith(
          AddMatchModel value, $Res Function(AddMatchModel) then) =
      _$AddMatchModelCopyWithImpl<$Res, AddMatchModel>;
  @useResult
  $Res call(
      {String? id,
      String matchType,
      AddTeamModel homeTeam,
      AddTeamModel awayTeam,
      int noOfHalfs,
      int minsEachHalf,
      int startingPlayers,
      int noOfSubs,
      String substitutionType,
      DateTime matchDate});

  $AddTeamModelCopyWith<$Res> get homeTeam;
  $AddTeamModelCopyWith<$Res> get awayTeam;
}

/// @nodoc
class _$AddMatchModelCopyWithImpl<$Res, $Val extends AddMatchModel>
    implements $AddMatchModelCopyWith<$Res> {
  _$AddMatchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchType = null,
    Object? homeTeam = null,
    Object? awayTeam = null,
    Object? noOfHalfs = null,
    Object? minsEachHalf = null,
    Object? startingPlayers = null,
    Object? noOfSubs = null,
    Object? substitutionType = null,
    Object? matchDate = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchType: null == matchType
          ? _value.matchType
          : matchType // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeam: null == homeTeam
          ? _value.homeTeam
          : homeTeam // ignore: cast_nullable_to_non_nullable
              as AddTeamModel,
      awayTeam: null == awayTeam
          ? _value.awayTeam
          : awayTeam // ignore: cast_nullable_to_non_nullable
              as AddTeamModel,
      noOfHalfs: null == noOfHalfs
          ? _value.noOfHalfs
          : noOfHalfs // ignore: cast_nullable_to_non_nullable
              as int,
      minsEachHalf: null == minsEachHalf
          ? _value.minsEachHalf
          : minsEachHalf // ignore: cast_nullable_to_non_nullable
              as int,
      startingPlayers: null == startingPlayers
          ? _value.startingPlayers
          : startingPlayers // ignore: cast_nullable_to_non_nullable
              as int,
      noOfSubs: null == noOfSubs
          ? _value.noOfSubs
          : noOfSubs // ignore: cast_nullable_to_non_nullable
              as int,
      substitutionType: null == substitutionType
          ? _value.substitutionType
          : substitutionType // ignore: cast_nullable_to_non_nullable
              as String,
      matchDate: null == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AddTeamModelCopyWith<$Res> get homeTeam {
    return $AddTeamModelCopyWith<$Res>(_value.homeTeam, (value) {
      return _then(_value.copyWith(homeTeam: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AddTeamModelCopyWith<$Res> get awayTeam {
    return $AddTeamModelCopyWith<$Res>(_value.awayTeam, (value) {
      return _then(_value.copyWith(awayTeam: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AddMatchModelCopyWith<$Res>
    implements $AddMatchModelCopyWith<$Res> {
  factory _$$_AddMatchModelCopyWith(
          _$_AddMatchModel value, $Res Function(_$_AddMatchModel) then) =
      __$$_AddMatchModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String matchType,
      AddTeamModel homeTeam,
      AddTeamModel awayTeam,
      int noOfHalfs,
      int minsEachHalf,
      int startingPlayers,
      int noOfSubs,
      String substitutionType,
      DateTime matchDate});

  @override
  $AddTeamModelCopyWith<$Res> get homeTeam;
  @override
  $AddTeamModelCopyWith<$Res> get awayTeam;
}

/// @nodoc
class __$$_AddMatchModelCopyWithImpl<$Res>
    extends _$AddMatchModelCopyWithImpl<$Res, _$_AddMatchModel>
    implements _$$_AddMatchModelCopyWith<$Res> {
  __$$_AddMatchModelCopyWithImpl(
      _$_AddMatchModel _value, $Res Function(_$_AddMatchModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchType = null,
    Object? homeTeam = null,
    Object? awayTeam = null,
    Object? noOfHalfs = null,
    Object? minsEachHalf = null,
    Object? startingPlayers = null,
    Object? noOfSubs = null,
    Object? substitutionType = null,
    Object? matchDate = null,
  }) {
    return _then(_$_AddMatchModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchType: null == matchType
          ? _value.matchType
          : matchType // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeam: null == homeTeam
          ? _value.homeTeam
          : homeTeam // ignore: cast_nullable_to_non_nullable
              as AddTeamModel,
      awayTeam: null == awayTeam
          ? _value.awayTeam
          : awayTeam // ignore: cast_nullable_to_non_nullable
              as AddTeamModel,
      noOfHalfs: null == noOfHalfs
          ? _value.noOfHalfs
          : noOfHalfs // ignore: cast_nullable_to_non_nullable
              as int,
      minsEachHalf: null == minsEachHalf
          ? _value.minsEachHalf
          : minsEachHalf // ignore: cast_nullable_to_non_nullable
              as int,
      startingPlayers: null == startingPlayers
          ? _value.startingPlayers
          : startingPlayers // ignore: cast_nullable_to_non_nullable
              as int,
      noOfSubs: null == noOfSubs
          ? _value.noOfSubs
          : noOfSubs // ignore: cast_nullable_to_non_nullable
              as int,
      substitutionType: null == substitutionType
          ? _value.substitutionType
          : substitutionType // ignore: cast_nullable_to_non_nullable
              as String,
      matchDate: null == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AddMatchModel extends _AddMatchModel {
  _$_AddMatchModel(
      {this.id,
      required this.matchType,
      required this.homeTeam,
      required this.awayTeam,
      required this.noOfHalfs,
      required this.minsEachHalf,
      required this.startingPlayers,
      required this.noOfSubs,
      required this.substitutionType,
      required this.matchDate})
      : super._();

  factory _$_AddMatchModel.fromJson(Map<String, dynamic> json) =>
      _$$_AddMatchModelFromJson(json);

  @override
  final String? id;
  @override
  final String matchType;
  @override
  final AddTeamModel homeTeam;
  @override
  final AddTeamModel awayTeam;
  @override
  final int noOfHalfs;
  @override
  final int minsEachHalf;
  @override
  final int startingPlayers;
  @override
  final int noOfSubs;
  @override
  final String substitutionType;
  @override
  final DateTime matchDate;

  @override
  String toString() {
    return 'AddMatchModel(id: $id, matchType: $matchType, homeTeam: $homeTeam, awayTeam: $awayTeam, noOfHalfs: $noOfHalfs, minsEachHalf: $minsEachHalf, startingPlayers: $startingPlayers, noOfSubs: $noOfSubs, substitutionType: $substitutionType, matchDate: $matchDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddMatchModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchType, matchType) ||
                other.matchType == matchType) &&
            (identical(other.homeTeam, homeTeam) ||
                other.homeTeam == homeTeam) &&
            (identical(other.awayTeam, awayTeam) ||
                other.awayTeam == awayTeam) &&
            (identical(other.noOfHalfs, noOfHalfs) ||
                other.noOfHalfs == noOfHalfs) &&
            (identical(other.minsEachHalf, minsEachHalf) ||
                other.minsEachHalf == minsEachHalf) &&
            (identical(other.startingPlayers, startingPlayers) ||
                other.startingPlayers == startingPlayers) &&
            (identical(other.noOfSubs, noOfSubs) ||
                other.noOfSubs == noOfSubs) &&
            (identical(other.substitutionType, substitutionType) ||
                other.substitutionType == substitutionType) &&
            (identical(other.matchDate, matchDate) ||
                other.matchDate == matchDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      matchType,
      homeTeam,
      awayTeam,
      noOfHalfs,
      minsEachHalf,
      startingPlayers,
      noOfSubs,
      substitutionType,
      matchDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddMatchModelCopyWith<_$_AddMatchModel> get copyWith =>
      __$$_AddMatchModelCopyWithImpl<_$_AddMatchModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AddMatchModelToJson(
      this,
    );
  }
}

abstract class _AddMatchModel extends AddMatchModel {
  factory _AddMatchModel(
      {final String? id,
      required final String matchType,
      required final AddTeamModel homeTeam,
      required final AddTeamModel awayTeam,
      required final int noOfHalfs,
      required final int minsEachHalf,
      required final int startingPlayers,
      required final int noOfSubs,
      required final String substitutionType,
      required final DateTime matchDate}) = _$_AddMatchModel;
  _AddMatchModel._() : super._();

  factory _AddMatchModel.fromJson(Map<String, dynamic> json) =
      _$_AddMatchModel.fromJson;

  @override
  String? get id;
  @override
  String get matchType;
  @override
  AddTeamModel get homeTeam;
  @override
  AddTeamModel get awayTeam;
  @override
  int get noOfHalfs;
  @override
  int get minsEachHalf;
  @override
  int get startingPlayers;
  @override
  int get noOfSubs;
  @override
  String get substitutionType;
  @override
  DateTime get matchDate;
  @override
  @JsonKey(ignore: true)
  _$$_AddMatchModelCopyWith<_$_AddMatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}
