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
  String get tournamentId => throw _privateConstructorUsedError;
  String get matchType => throw _privateConstructorUsedError;
  String get matchStatus => throw _privateConstructorUsedError;
  String get homeTeamId => throw _privateConstructorUsedError;
  String get awayTeamId => throw _privateConstructorUsedError;
  int get noOfHalfs => throw _privateConstructorUsedError;
  int get minsEachHalf => throw _privateConstructorUsedError;
  int get startingPlayers => throw _privateConstructorUsedError;
  int get noOfSubs => throw _privateConstructorUsedError;
  String get substitutionType => throw _privateConstructorUsedError;
  DateTime get matchDate => throw _privateConstructorUsedError;
  Map<String, String>? get homeLineup => throw _privateConstructorUsedError;
  List<String>? get homeSubstitutes => throw _privateConstructorUsedError;
  Map<String, String>? get awayLineup => throw _privateConstructorUsedError;
  List<String>? get awaySubstitutes => throw _privateConstructorUsedError;
  AddTeamModel? get homeTeamModel => throw _privateConstructorUsedError;
  AddTeamModel? get awayTeamModel => throw _privateConstructorUsedError;
  int get homeTeamScore => throw _privateConstructorUsedError;
  int get awayTeamScore => throw _privateConstructorUsedError;
  int? get currTimer => throw _privateConstructorUsedError;
  int? get currHalf => throw _privateConstructorUsedError;
  List<Map<String, dynamic>>? get keyEvents =>
      throw _privateConstructorUsedError;

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
      String tournamentId,
      String matchType,
      String matchStatus,
      String homeTeamId,
      String awayTeamId,
      int noOfHalfs,
      int minsEachHalf,
      int startingPlayers,
      int noOfSubs,
      String substitutionType,
      DateTime matchDate,
      Map<String, String>? homeLineup,
      List<String>? homeSubstitutes,
      Map<String, String>? awayLineup,
      List<String>? awaySubstitutes,
      AddTeamModel? homeTeamModel,
      AddTeamModel? awayTeamModel,
      int homeTeamScore,
      int awayTeamScore,
      int? currTimer,
      int? currHalf,
      List<Map<String, dynamic>>? keyEvents});

  $AddTeamModelCopyWith<$Res>? get homeTeamModel;
  $AddTeamModelCopyWith<$Res>? get awayTeamModel;
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
    Object? tournamentId = null,
    Object? matchType = null,
    Object? matchStatus = null,
    Object? homeTeamId = null,
    Object? awayTeamId = null,
    Object? noOfHalfs = null,
    Object? minsEachHalf = null,
    Object? startingPlayers = null,
    Object? noOfSubs = null,
    Object? substitutionType = null,
    Object? matchDate = null,
    Object? homeLineup = freezed,
    Object? homeSubstitutes = freezed,
    Object? awayLineup = freezed,
    Object? awaySubstitutes = freezed,
    Object? homeTeamModel = freezed,
    Object? awayTeamModel = freezed,
    Object? homeTeamScore = null,
    Object? awayTeamScore = null,
    Object? currTimer = freezed,
    Object? currHalf = freezed,
    Object? keyEvents = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: null == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String,
      matchType: null == matchType
          ? _value.matchType
          : matchType // ignore: cast_nullable_to_non_nullable
              as String,
      matchStatus: null == matchStatus
          ? _value.matchStatus
          : matchStatus // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeamId: null == homeTeamId
          ? _value.homeTeamId
          : homeTeamId // ignore: cast_nullable_to_non_nullable
              as String,
      awayTeamId: null == awayTeamId
          ? _value.awayTeamId
          : awayTeamId // ignore: cast_nullable_to_non_nullable
              as String,
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
      homeLineup: freezed == homeLineup
          ? _value.homeLineup
          : homeLineup // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      homeSubstitutes: freezed == homeSubstitutes
          ? _value.homeSubstitutes
          : homeSubstitutes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      awayLineup: freezed == awayLineup
          ? _value.awayLineup
          : awayLineup // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      awaySubstitutes: freezed == awaySubstitutes
          ? _value.awaySubstitutes
          : awaySubstitutes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      homeTeamModel: freezed == homeTeamModel
          ? _value.homeTeamModel
          : homeTeamModel // ignore: cast_nullable_to_non_nullable
              as AddTeamModel?,
      awayTeamModel: freezed == awayTeamModel
          ? _value.awayTeamModel
          : awayTeamModel // ignore: cast_nullable_to_non_nullable
              as AddTeamModel?,
      homeTeamScore: null == homeTeamScore
          ? _value.homeTeamScore
          : homeTeamScore // ignore: cast_nullable_to_non_nullable
              as int,
      awayTeamScore: null == awayTeamScore
          ? _value.awayTeamScore
          : awayTeamScore // ignore: cast_nullable_to_non_nullable
              as int,
      currTimer: freezed == currTimer
          ? _value.currTimer
          : currTimer // ignore: cast_nullable_to_non_nullable
              as int?,
      currHalf: freezed == currHalf
          ? _value.currHalf
          : currHalf // ignore: cast_nullable_to_non_nullable
              as int?,
      keyEvents: freezed == keyEvents
          ? _value.keyEvents
          : keyEvents // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AddTeamModelCopyWith<$Res>? get homeTeamModel {
    if (_value.homeTeamModel == null) {
      return null;
    }

    return $AddTeamModelCopyWith<$Res>(_value.homeTeamModel!, (value) {
      return _then(_value.copyWith(homeTeamModel: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AddTeamModelCopyWith<$Res>? get awayTeamModel {
    if (_value.awayTeamModel == null) {
      return null;
    }

    return $AddTeamModelCopyWith<$Res>(_value.awayTeamModel!, (value) {
      return _then(_value.copyWith(awayTeamModel: value) as $Val);
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
      String tournamentId,
      String matchType,
      String matchStatus,
      String homeTeamId,
      String awayTeamId,
      int noOfHalfs,
      int minsEachHalf,
      int startingPlayers,
      int noOfSubs,
      String substitutionType,
      DateTime matchDate,
      Map<String, String>? homeLineup,
      List<String>? homeSubstitutes,
      Map<String, String>? awayLineup,
      List<String>? awaySubstitutes,
      AddTeamModel? homeTeamModel,
      AddTeamModel? awayTeamModel,
      int homeTeamScore,
      int awayTeamScore,
      int? currTimer,
      int? currHalf,
      List<Map<String, dynamic>>? keyEvents});

  @override
  $AddTeamModelCopyWith<$Res>? get homeTeamModel;
  @override
  $AddTeamModelCopyWith<$Res>? get awayTeamModel;
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
    Object? tournamentId = null,
    Object? matchType = null,
    Object? matchStatus = null,
    Object? homeTeamId = null,
    Object? awayTeamId = null,
    Object? noOfHalfs = null,
    Object? minsEachHalf = null,
    Object? startingPlayers = null,
    Object? noOfSubs = null,
    Object? substitutionType = null,
    Object? matchDate = null,
    Object? homeLineup = freezed,
    Object? homeSubstitutes = freezed,
    Object? awayLineup = freezed,
    Object? awaySubstitutes = freezed,
    Object? homeTeamModel = freezed,
    Object? awayTeamModel = freezed,
    Object? homeTeamScore = null,
    Object? awayTeamScore = null,
    Object? currTimer = freezed,
    Object? currHalf = freezed,
    Object? keyEvents = freezed,
  }) {
    return _then(_$_AddMatchModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: null == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String,
      matchType: null == matchType
          ? _value.matchType
          : matchType // ignore: cast_nullable_to_non_nullable
              as String,
      matchStatus: null == matchStatus
          ? _value.matchStatus
          : matchStatus // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeamId: null == homeTeamId
          ? _value.homeTeamId
          : homeTeamId // ignore: cast_nullable_to_non_nullable
              as String,
      awayTeamId: null == awayTeamId
          ? _value.awayTeamId
          : awayTeamId // ignore: cast_nullable_to_non_nullable
              as String,
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
      homeLineup: freezed == homeLineup
          ? _value._homeLineup
          : homeLineup // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      homeSubstitutes: freezed == homeSubstitutes
          ? _value._homeSubstitutes
          : homeSubstitutes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      awayLineup: freezed == awayLineup
          ? _value._awayLineup
          : awayLineup // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      awaySubstitutes: freezed == awaySubstitutes
          ? _value._awaySubstitutes
          : awaySubstitutes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      homeTeamModel: freezed == homeTeamModel
          ? _value.homeTeamModel
          : homeTeamModel // ignore: cast_nullable_to_non_nullable
              as AddTeamModel?,
      awayTeamModel: freezed == awayTeamModel
          ? _value.awayTeamModel
          : awayTeamModel // ignore: cast_nullable_to_non_nullable
              as AddTeamModel?,
      homeTeamScore: null == homeTeamScore
          ? _value.homeTeamScore
          : homeTeamScore // ignore: cast_nullable_to_non_nullable
              as int,
      awayTeamScore: null == awayTeamScore
          ? _value.awayTeamScore
          : awayTeamScore // ignore: cast_nullable_to_non_nullable
              as int,
      currTimer: freezed == currTimer
          ? _value.currTimer
          : currTimer // ignore: cast_nullable_to_non_nullable
              as int?,
      currHalf: freezed == currHalf
          ? _value.currHalf
          : currHalf // ignore: cast_nullable_to_non_nullable
              as int?,
      keyEvents: freezed == keyEvents
          ? _value._keyEvents
          : keyEvents // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AddMatchModel extends _AddMatchModel {
  _$_AddMatchModel(
      {this.id,
      required this.tournamentId,
      required this.matchType,
      required this.matchStatus,
      required this.homeTeamId,
      required this.awayTeamId,
      required this.noOfHalfs,
      required this.minsEachHalf,
      required this.startingPlayers,
      required this.noOfSubs,
      required this.substitutionType,
      required this.matchDate,
      final Map<String, String>? homeLineup,
      final List<String>? homeSubstitutes,
      final Map<String, String>? awayLineup,
      final List<String>? awaySubstitutes,
      this.homeTeamModel,
      this.awayTeamModel,
      required this.homeTeamScore,
      required this.awayTeamScore,
      this.currTimer,
      this.currHalf,
      final List<Map<String, dynamic>>? keyEvents})
      : _homeLineup = homeLineup,
        _homeSubstitutes = homeSubstitutes,
        _awayLineup = awayLineup,
        _awaySubstitutes = awaySubstitutes,
        _keyEvents = keyEvents,
        super._();

  factory _$_AddMatchModel.fromJson(Map<String, dynamic> json) =>
      _$$_AddMatchModelFromJson(json);

  @override
  final String? id;
  @override
  final String tournamentId;
  @override
  final String matchType;
  @override
  final String matchStatus;
  @override
  final String homeTeamId;
  @override
  final String awayTeamId;
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
  final Map<String, String>? _homeLineup;
  @override
  Map<String, String>? get homeLineup {
    final value = _homeLineup;
    if (value == null) return null;
    if (_homeLineup is EqualUnmodifiableMapView) return _homeLineup;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _homeSubstitutes;
  @override
  List<String>? get homeSubstitutes {
    final value = _homeSubstitutes;
    if (value == null) return null;
    if (_homeSubstitutes is EqualUnmodifiableListView) return _homeSubstitutes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, String>? _awayLineup;
  @override
  Map<String, String>? get awayLineup {
    final value = _awayLineup;
    if (value == null) return null;
    if (_awayLineup is EqualUnmodifiableMapView) return _awayLineup;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _awaySubstitutes;
  @override
  List<String>? get awaySubstitutes {
    final value = _awaySubstitutes;
    if (value == null) return null;
    if (_awaySubstitutes is EqualUnmodifiableListView) return _awaySubstitutes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final AddTeamModel? homeTeamModel;
  @override
  final AddTeamModel? awayTeamModel;
  @override
  final int homeTeamScore;
  @override
  final int awayTeamScore;
  @override
  final int? currTimer;
  @override
  final int? currHalf;
  final List<Map<String, dynamic>>? _keyEvents;
  @override
  List<Map<String, dynamic>>? get keyEvents {
    final value = _keyEvents;
    if (value == null) return null;
    if (_keyEvents is EqualUnmodifiableListView) return _keyEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AddMatchModel(id: $id, tournamentId: $tournamentId, matchType: $matchType, matchStatus: $matchStatus, homeTeamId: $homeTeamId, awayTeamId: $awayTeamId, noOfHalfs: $noOfHalfs, minsEachHalf: $minsEachHalf, startingPlayers: $startingPlayers, noOfSubs: $noOfSubs, substitutionType: $substitutionType, matchDate: $matchDate, homeLineup: $homeLineup, homeSubstitutes: $homeSubstitutes, awayLineup: $awayLineup, awaySubstitutes: $awaySubstitutes, homeTeamModel: $homeTeamModel, awayTeamModel: $awayTeamModel, homeTeamScore: $homeTeamScore, awayTeamScore: $awayTeamScore, currTimer: $currTimer, currHalf: $currHalf, keyEvents: $keyEvents)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddMatchModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.matchType, matchType) ||
                other.matchType == matchType) &&
            (identical(other.matchStatus, matchStatus) ||
                other.matchStatus == matchStatus) &&
            (identical(other.homeTeamId, homeTeamId) ||
                other.homeTeamId == homeTeamId) &&
            (identical(other.awayTeamId, awayTeamId) ||
                other.awayTeamId == awayTeamId) &&
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
                other.matchDate == matchDate) &&
            const DeepCollectionEquality()
                .equals(other._homeLineup, _homeLineup) &&
            const DeepCollectionEquality()
                .equals(other._homeSubstitutes, _homeSubstitutes) &&
            const DeepCollectionEquality()
                .equals(other._awayLineup, _awayLineup) &&
            const DeepCollectionEquality()
                .equals(other._awaySubstitutes, _awaySubstitutes) &&
            (identical(other.homeTeamModel, homeTeamModel) ||
                other.homeTeamModel == homeTeamModel) &&
            (identical(other.awayTeamModel, awayTeamModel) ||
                other.awayTeamModel == awayTeamModel) &&
            (identical(other.homeTeamScore, homeTeamScore) ||
                other.homeTeamScore == homeTeamScore) &&
            (identical(other.awayTeamScore, awayTeamScore) ||
                other.awayTeamScore == awayTeamScore) &&
            (identical(other.currTimer, currTimer) ||
                other.currTimer == currTimer) &&
            (identical(other.currHalf, currHalf) ||
                other.currHalf == currHalf) &&
            const DeepCollectionEquality()
                .equals(other._keyEvents, _keyEvents));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        tournamentId,
        matchType,
        matchStatus,
        homeTeamId,
        awayTeamId,
        noOfHalfs,
        minsEachHalf,
        startingPlayers,
        noOfSubs,
        substitutionType,
        matchDate,
        const DeepCollectionEquality().hash(_homeLineup),
        const DeepCollectionEquality().hash(_homeSubstitutes),
        const DeepCollectionEquality().hash(_awayLineup),
        const DeepCollectionEquality().hash(_awaySubstitutes),
        homeTeamModel,
        awayTeamModel,
        homeTeamScore,
        awayTeamScore,
        currTimer,
        currHalf,
        const DeepCollectionEquality().hash(_keyEvents)
      ]);

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
      required final String tournamentId,
      required final String matchType,
      required final String matchStatus,
      required final String homeTeamId,
      required final String awayTeamId,
      required final int noOfHalfs,
      required final int minsEachHalf,
      required final int startingPlayers,
      required final int noOfSubs,
      required final String substitutionType,
      required final DateTime matchDate,
      final Map<String, String>? homeLineup,
      final List<String>? homeSubstitutes,
      final Map<String, String>? awayLineup,
      final List<String>? awaySubstitutes,
      final AddTeamModel? homeTeamModel,
      final AddTeamModel? awayTeamModel,
      required final int homeTeamScore,
      required final int awayTeamScore,
      final int? currTimer,
      final int? currHalf,
      final List<Map<String, dynamic>>? keyEvents}) = _$_AddMatchModel;
  _AddMatchModel._() : super._();

  factory _AddMatchModel.fromJson(Map<String, dynamic> json) =
      _$_AddMatchModel.fromJson;

  @override
  String? get id;
  @override
  String get tournamentId;
  @override
  String get matchType;
  @override
  String get matchStatus;
  @override
  String get homeTeamId;
  @override
  String get awayTeamId;
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
  Map<String, String>? get homeLineup;
  @override
  List<String>? get homeSubstitutes;
  @override
  Map<String, String>? get awayLineup;
  @override
  List<String>? get awaySubstitutes;
  @override
  AddTeamModel? get homeTeamModel;
  @override
  AddTeamModel? get awayTeamModel;
  @override
  int get homeTeamScore;
  @override
  int get awayTeamScore;
  @override
  int? get currTimer;
  @override
  int? get currHalf;
  @override
  List<Map<String, dynamic>>? get keyEvents;
  @override
  @JsonKey(ignore: true)
  _$$_AddMatchModelCopyWith<_$_AddMatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}
