// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_tournament_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AddTournamentModel _$AddTournamentModelFromJson(Map<String, dynamic> json) {
  return _AddTournamentModel.fromJson(json);
}

/// @nodoc
mixin _$AddTournamentModel {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get organizerId => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  int get noOfHalfs => throw _privateConstructorUsedError;
  int get minsEachHalf => throw _privateConstructorUsedError;
  String get logoUri => throw _privateConstructorUsedError;
  String get bannerUri => throw _privateConstructorUsedError;
  List<dynamic> get scorers => throw _privateConstructorUsedError;
  List<String> get followersId => throw _privateConstructorUsedError;
  List<String>? get teams => throw _privateConstructorUsedError;
  Map<String, PlayersTournamentModel> get playerStats =>
      throw _privateConstructorUsedError;
  Map<String, TeamPointsModel> get pointsTable =>
      throw _privateConstructorUsedError;
  Map<String, int> get goalLeaderboard => throw _privateConstructorUsedError;
  Map<String, int> get assistLeaderboard => throw _privateConstructorUsedError;
  Map<String, int> get cleanSheetLeaderboard =>
      throw _privateConstructorUsedError;
  Map<String, int> get yellowCardLeaderboard =>
      throw _privateConstructorUsedError;
  Map<String, int> get redCardLeaderboard => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddTournamentModelCopyWith<AddTournamentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddTournamentModelCopyWith<$Res> {
  factory $AddTournamentModelCopyWith(
          AddTournamentModel value, $Res Function(AddTournamentModel) then) =
      _$AddTournamentModelCopyWithImpl<$Res, AddTournamentModel>;
  @useResult
  $Res call(
      {String? id,
      String name,
      String organizerId,
      DateTime startDate,
      DateTime endDate,
      int noOfHalfs,
      int minsEachHalf,
      String logoUri,
      String bannerUri,
      List<dynamic> scorers,
      List<String> followersId,
      List<String>? teams,
      Map<String, PlayersTournamentModel> playerStats,
      Map<String, TeamPointsModel> pointsTable,
      Map<String, int> goalLeaderboard,
      Map<String, int> assistLeaderboard,
      Map<String, int> cleanSheetLeaderboard,
      Map<String, int> yellowCardLeaderboard,
      Map<String, int> redCardLeaderboard});
}

/// @nodoc
class _$AddTournamentModelCopyWithImpl<$Res, $Val extends AddTournamentModel>
    implements $AddTournamentModelCopyWith<$Res> {
  _$AddTournamentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? organizerId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? noOfHalfs = null,
    Object? minsEachHalf = null,
    Object? logoUri = null,
    Object? bannerUri = null,
    Object? scorers = null,
    Object? followersId = null,
    Object? teams = freezed,
    Object? playerStats = null,
    Object? pointsTable = null,
    Object? goalLeaderboard = null,
    Object? assistLeaderboard = null,
    Object? cleanSheetLeaderboard = null,
    Object? yellowCardLeaderboard = null,
    Object? redCardLeaderboard = null,
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
      organizerId: null == organizerId
          ? _value.organizerId
          : organizerId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      noOfHalfs: null == noOfHalfs
          ? _value.noOfHalfs
          : noOfHalfs // ignore: cast_nullable_to_non_nullable
              as int,
      minsEachHalf: null == minsEachHalf
          ? _value.minsEachHalf
          : minsEachHalf // ignore: cast_nullable_to_non_nullable
              as int,
      logoUri: null == logoUri
          ? _value.logoUri
          : logoUri // ignore: cast_nullable_to_non_nullable
              as String,
      bannerUri: null == bannerUri
          ? _value.bannerUri
          : bannerUri // ignore: cast_nullable_to_non_nullable
              as String,
      scorers: null == scorers
          ? _value.scorers
          : scorers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      followersId: null == followersId
          ? _value.followersId
          : followersId // ignore: cast_nullable_to_non_nullable
              as List<String>,
      teams: freezed == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      playerStats: null == playerStats
          ? _value.playerStats
          : playerStats // ignore: cast_nullable_to_non_nullable
              as Map<String, PlayersTournamentModel>,
      pointsTable: null == pointsTable
          ? _value.pointsTable
          : pointsTable // ignore: cast_nullable_to_non_nullable
              as Map<String, TeamPointsModel>,
      goalLeaderboard: null == goalLeaderboard
          ? _value.goalLeaderboard
          : goalLeaderboard // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      assistLeaderboard: null == assistLeaderboard
          ? _value.assistLeaderboard
          : assistLeaderboard // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      cleanSheetLeaderboard: null == cleanSheetLeaderboard
          ? _value.cleanSheetLeaderboard
          : cleanSheetLeaderboard // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      yellowCardLeaderboard: null == yellowCardLeaderboard
          ? _value.yellowCardLeaderboard
          : yellowCardLeaderboard // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      redCardLeaderboard: null == redCardLeaderboard
          ? _value.redCardLeaderboard
          : redCardLeaderboard // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddTournamentModelCopyWith<$Res>
    implements $AddTournamentModelCopyWith<$Res> {
  factory _$$_AddTournamentModelCopyWith(_$_AddTournamentModel value,
          $Res Function(_$_AddTournamentModel) then) =
      __$$_AddTournamentModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String name,
      String organizerId,
      DateTime startDate,
      DateTime endDate,
      int noOfHalfs,
      int minsEachHalf,
      String logoUri,
      String bannerUri,
      List<dynamic> scorers,
      List<String> followersId,
      List<String>? teams,
      Map<String, PlayersTournamentModel> playerStats,
      Map<String, TeamPointsModel> pointsTable,
      Map<String, int> goalLeaderboard,
      Map<String, int> assistLeaderboard,
      Map<String, int> cleanSheetLeaderboard,
      Map<String, int> yellowCardLeaderboard,
      Map<String, int> redCardLeaderboard});
}

/// @nodoc
class __$$_AddTournamentModelCopyWithImpl<$Res>
    extends _$AddTournamentModelCopyWithImpl<$Res, _$_AddTournamentModel>
    implements _$$_AddTournamentModelCopyWith<$Res> {
  __$$_AddTournamentModelCopyWithImpl(
      _$_AddTournamentModel _value, $Res Function(_$_AddTournamentModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? organizerId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? noOfHalfs = null,
    Object? minsEachHalf = null,
    Object? logoUri = null,
    Object? bannerUri = null,
    Object? scorers = null,
    Object? followersId = null,
    Object? teams = freezed,
    Object? playerStats = null,
    Object? pointsTable = null,
    Object? goalLeaderboard = null,
    Object? assistLeaderboard = null,
    Object? cleanSheetLeaderboard = null,
    Object? yellowCardLeaderboard = null,
    Object? redCardLeaderboard = null,
  }) {
    return _then(_$_AddTournamentModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      organizerId: null == organizerId
          ? _value.organizerId
          : organizerId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      noOfHalfs: null == noOfHalfs
          ? _value.noOfHalfs
          : noOfHalfs // ignore: cast_nullable_to_non_nullable
              as int,
      minsEachHalf: null == minsEachHalf
          ? _value.minsEachHalf
          : minsEachHalf // ignore: cast_nullable_to_non_nullable
              as int,
      logoUri: null == logoUri
          ? _value.logoUri
          : logoUri // ignore: cast_nullable_to_non_nullable
              as String,
      bannerUri: null == bannerUri
          ? _value.bannerUri
          : bannerUri // ignore: cast_nullable_to_non_nullable
              as String,
      scorers: null == scorers
          ? _value._scorers
          : scorers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      followersId: null == followersId
          ? _value._followersId
          : followersId // ignore: cast_nullable_to_non_nullable
              as List<String>,
      teams: freezed == teams
          ? _value._teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      playerStats: null == playerStats
          ? _value._playerStats
          : playerStats // ignore: cast_nullable_to_non_nullable
              as Map<String, PlayersTournamentModel>,
      pointsTable: null == pointsTable
          ? _value._pointsTable
          : pointsTable // ignore: cast_nullable_to_non_nullable
              as Map<String, TeamPointsModel>,
      goalLeaderboard: null == goalLeaderboard
          ? _value._goalLeaderboard
          : goalLeaderboard // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      assistLeaderboard: null == assistLeaderboard
          ? _value._assistLeaderboard
          : assistLeaderboard // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      cleanSheetLeaderboard: null == cleanSheetLeaderboard
          ? _value._cleanSheetLeaderboard
          : cleanSheetLeaderboard // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      yellowCardLeaderboard: null == yellowCardLeaderboard
          ? _value._yellowCardLeaderboard
          : yellowCardLeaderboard // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      redCardLeaderboard: null == redCardLeaderboard
          ? _value._redCardLeaderboard
          : redCardLeaderboard // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AddTournamentModel extends _AddTournamentModel {
  _$_AddTournamentModel(
      {this.id,
      required this.name,
      required this.organizerId,
      required this.startDate,
      required this.endDate,
      required this.noOfHalfs,
      required this.minsEachHalf,
      required this.logoUri,
      required this.bannerUri,
      required final List<dynamic> scorers,
      required final List<String> followersId,
      final List<String>? teams,
      required final Map<String, PlayersTournamentModel> playerStats,
      required final Map<String, TeamPointsModel> pointsTable,
      required final Map<String, int> goalLeaderboard,
      required final Map<String, int> assistLeaderboard,
      required final Map<String, int> cleanSheetLeaderboard,
      required final Map<String, int> yellowCardLeaderboard,
      required final Map<String, int> redCardLeaderboard})
      : _scorers = scorers,
        _followersId = followersId,
        _teams = teams,
        _playerStats = playerStats,
        _pointsTable = pointsTable,
        _goalLeaderboard = goalLeaderboard,
        _assistLeaderboard = assistLeaderboard,
        _cleanSheetLeaderboard = cleanSheetLeaderboard,
        _yellowCardLeaderboard = yellowCardLeaderboard,
        _redCardLeaderboard = redCardLeaderboard,
        super._();

  factory _$_AddTournamentModel.fromJson(Map<String, dynamic> json) =>
      _$$_AddTournamentModelFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String organizerId;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final int noOfHalfs;
  @override
  final int minsEachHalf;
  @override
  final String logoUri;
  @override
  final String bannerUri;
  final List<dynamic> _scorers;
  @override
  List<dynamic> get scorers {
    if (_scorers is EqualUnmodifiableListView) return _scorers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scorers);
  }

  final List<String> _followersId;
  @override
  List<String> get followersId {
    if (_followersId is EqualUnmodifiableListView) return _followersId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_followersId);
  }

  final List<String>? _teams;
  @override
  List<String>? get teams {
    final value = _teams;
    if (value == null) return null;
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, PlayersTournamentModel> _playerStats;
  @override
  Map<String, PlayersTournamentModel> get playerStats {
    if (_playerStats is EqualUnmodifiableMapView) return _playerStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playerStats);
  }

  final Map<String, TeamPointsModel> _pointsTable;
  @override
  Map<String, TeamPointsModel> get pointsTable {
    if (_pointsTable is EqualUnmodifiableMapView) return _pointsTable;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_pointsTable);
  }

  final Map<String, int> _goalLeaderboard;
  @override
  Map<String, int> get goalLeaderboard {
    if (_goalLeaderboard is EqualUnmodifiableMapView) return _goalLeaderboard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_goalLeaderboard);
  }

  final Map<String, int> _assistLeaderboard;
  @override
  Map<String, int> get assistLeaderboard {
    if (_assistLeaderboard is EqualUnmodifiableMapView)
      return _assistLeaderboard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_assistLeaderboard);
  }

  final Map<String, int> _cleanSheetLeaderboard;
  @override
  Map<String, int> get cleanSheetLeaderboard {
    if (_cleanSheetLeaderboard is EqualUnmodifiableMapView)
      return _cleanSheetLeaderboard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cleanSheetLeaderboard);
  }

  final Map<String, int> _yellowCardLeaderboard;
  @override
  Map<String, int> get yellowCardLeaderboard {
    if (_yellowCardLeaderboard is EqualUnmodifiableMapView)
      return _yellowCardLeaderboard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_yellowCardLeaderboard);
  }

  final Map<String, int> _redCardLeaderboard;
  @override
  Map<String, int> get redCardLeaderboard {
    if (_redCardLeaderboard is EqualUnmodifiableMapView)
      return _redCardLeaderboard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_redCardLeaderboard);
  }

  @override
  String toString() {
    return 'AddTournamentModel(id: $id, name: $name, organizerId: $organizerId, startDate: $startDate, endDate: $endDate, noOfHalfs: $noOfHalfs, minsEachHalf: $minsEachHalf, logoUri: $logoUri, bannerUri: $bannerUri, scorers: $scorers, followersId: $followersId, teams: $teams, playerStats: $playerStats, pointsTable: $pointsTable, goalLeaderboard: $goalLeaderboard, assistLeaderboard: $assistLeaderboard, cleanSheetLeaderboard: $cleanSheetLeaderboard, yellowCardLeaderboard: $yellowCardLeaderboard, redCardLeaderboard: $redCardLeaderboard)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddTournamentModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.organizerId, organizerId) ||
                other.organizerId == organizerId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.noOfHalfs, noOfHalfs) ||
                other.noOfHalfs == noOfHalfs) &&
            (identical(other.minsEachHalf, minsEachHalf) ||
                other.minsEachHalf == minsEachHalf) &&
            (identical(other.logoUri, logoUri) || other.logoUri == logoUri) &&
            (identical(other.bannerUri, bannerUri) ||
                other.bannerUri == bannerUri) &&
            const DeepCollectionEquality().equals(other._scorers, _scorers) &&
            const DeepCollectionEquality()
                .equals(other._followersId, _followersId) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            const DeepCollectionEquality()
                .equals(other._playerStats, _playerStats) &&
            const DeepCollectionEquality()
                .equals(other._pointsTable, _pointsTable) &&
            const DeepCollectionEquality()
                .equals(other._goalLeaderboard, _goalLeaderboard) &&
            const DeepCollectionEquality()
                .equals(other._assistLeaderboard, _assistLeaderboard) &&
            const DeepCollectionEquality()
                .equals(other._cleanSheetLeaderboard, _cleanSheetLeaderboard) &&
            const DeepCollectionEquality()
                .equals(other._yellowCardLeaderboard, _yellowCardLeaderboard) &&
            const DeepCollectionEquality()
                .equals(other._redCardLeaderboard, _redCardLeaderboard));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        organizerId,
        startDate,
        endDate,
        noOfHalfs,
        minsEachHalf,
        logoUri,
        bannerUri,
        const DeepCollectionEquality().hash(_scorers),
        const DeepCollectionEquality().hash(_followersId),
        const DeepCollectionEquality().hash(_teams),
        const DeepCollectionEquality().hash(_playerStats),
        const DeepCollectionEquality().hash(_pointsTable),
        const DeepCollectionEquality().hash(_goalLeaderboard),
        const DeepCollectionEquality().hash(_assistLeaderboard),
        const DeepCollectionEquality().hash(_cleanSheetLeaderboard),
        const DeepCollectionEquality().hash(_yellowCardLeaderboard),
        const DeepCollectionEquality().hash(_redCardLeaderboard)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddTournamentModelCopyWith<_$_AddTournamentModel> get copyWith =>
      __$$_AddTournamentModelCopyWithImpl<_$_AddTournamentModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AddTournamentModelToJson(
      this,
    );
  }
}

abstract class _AddTournamentModel extends AddTournamentModel {
  factory _AddTournamentModel(
          {final String? id,
          required final String name,
          required final String organizerId,
          required final DateTime startDate,
          required final DateTime endDate,
          required final int noOfHalfs,
          required final int minsEachHalf,
          required final String logoUri,
          required final String bannerUri,
          required final List<dynamic> scorers,
          required final List<String> followersId,
          final List<String>? teams,
          required final Map<String, PlayersTournamentModel> playerStats,
          required final Map<String, TeamPointsModel> pointsTable,
          required final Map<String, int> goalLeaderboard,
          required final Map<String, int> assistLeaderboard,
          required final Map<String, int> cleanSheetLeaderboard,
          required final Map<String, int> yellowCardLeaderboard,
          required final Map<String, int> redCardLeaderboard}) =
      _$_AddTournamentModel;
  _AddTournamentModel._() : super._();

  factory _AddTournamentModel.fromJson(Map<String, dynamic> json) =
      _$_AddTournamentModel.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String get organizerId;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  int get noOfHalfs;
  @override
  int get minsEachHalf;
  @override
  String get logoUri;
  @override
  String get bannerUri;
  @override
  List<dynamic> get scorers;
  @override
  List<String> get followersId;
  @override
  List<String>? get teams;
  @override
  Map<String, PlayersTournamentModel> get playerStats;
  @override
  Map<String, TeamPointsModel> get pointsTable;
  @override
  Map<String, int> get goalLeaderboard;
  @override
  Map<String, int> get assistLeaderboard;
  @override
  Map<String, int> get cleanSheetLeaderboard;
  @override
  Map<String, int> get yellowCardLeaderboard;
  @override
  Map<String, int> get redCardLeaderboard;
  @override
  @JsonKey(ignore: true)
  _$$_AddTournamentModelCopyWith<_$_AddTournamentModel> get copyWith =>
      throw _privateConstructorUsedError;
}
