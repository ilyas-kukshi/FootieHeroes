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
  PlayerPersonalInfo get organizer => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  String get logoUri => throw _privateConstructorUsedError;
  String get bannerUri => throw _privateConstructorUsedError;
  List<dynamic>? get teams => throw _privateConstructorUsedError;

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
      PlayerPersonalInfo organizer,
      DateTime startDate,
      DateTime endDate,
      String logoUri,
      String bannerUri,
      List<dynamic>? teams});

  $PlayerPersonalInfoCopyWith<$Res> get organizer;
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
    Object? organizer = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? logoUri = null,
    Object? bannerUri = null,
    Object? teams = freezed,
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
      organizer: null == organizer
          ? _value.organizer
          : organizer // ignore: cast_nullable_to_non_nullable
              as PlayerPersonalInfo,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      logoUri: null == logoUri
          ? _value.logoUri
          : logoUri // ignore: cast_nullable_to_non_nullable
              as String,
      bannerUri: null == bannerUri
          ? _value.bannerUri
          : bannerUri // ignore: cast_nullable_to_non_nullable
              as String,
      teams: freezed == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerPersonalInfoCopyWith<$Res> get organizer {
    return $PlayerPersonalInfoCopyWith<$Res>(_value.organizer, (value) {
      return _then(_value.copyWith(organizer: value) as $Val);
    });
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
      PlayerPersonalInfo organizer,
      DateTime startDate,
      DateTime endDate,
      String logoUri,
      String bannerUri,
      List<dynamic>? teams});

  @override
  $PlayerPersonalInfoCopyWith<$Res> get organizer;
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
    Object? organizer = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? logoUri = null,
    Object? bannerUri = null,
    Object? teams = freezed,
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
      organizer: null == organizer
          ? _value.organizer
          : organizer // ignore: cast_nullable_to_non_nullable
              as PlayerPersonalInfo,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      logoUri: null == logoUri
          ? _value.logoUri
          : logoUri // ignore: cast_nullable_to_non_nullable
              as String,
      bannerUri: null == bannerUri
          ? _value.bannerUri
          : bannerUri // ignore: cast_nullable_to_non_nullable
              as String,
      teams: freezed == teams
          ? _value._teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AddTournamentModel extends _AddTournamentModel {
  _$_AddTournamentModel(
      {this.id,
      required this.name,
      required this.organizer,
      required this.startDate,
      required this.endDate,
      required this.logoUri,
      required this.bannerUri,
      final List<dynamic>? teams})
      : _teams = teams,
        super._();

  factory _$_AddTournamentModel.fromJson(Map<String, dynamic> json) =>
      _$$_AddTournamentModelFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final PlayerPersonalInfo organizer;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String logoUri;
  @override
  final String bannerUri;
  final List<dynamic>? _teams;
  @override
  List<dynamic>? get teams {
    final value = _teams;
    if (value == null) return null;
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AddTournamentModel(id: $id, name: $name, organizer: $organizer, startDate: $startDate, endDate: $endDate, logoUri: $logoUri, bannerUri: $bannerUri, teams: $teams)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddTournamentModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.organizer, organizer) ||
                other.organizer == organizer) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.logoUri, logoUri) || other.logoUri == logoUri) &&
            (identical(other.bannerUri, bannerUri) ||
                other.bannerUri == bannerUri) &&
            const DeepCollectionEquality().equals(other._teams, _teams));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, organizer, startDate,
      endDate, logoUri, bannerUri, const DeepCollectionEquality().hash(_teams));

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
      required final PlayerPersonalInfo organizer,
      required final DateTime startDate,
      required final DateTime endDate,
      required final String logoUri,
      required final String bannerUri,
      final List<dynamic>? teams}) = _$_AddTournamentModel;
  _AddTournamentModel._() : super._();

  factory _AddTournamentModel.fromJson(Map<String, dynamic> json) =
      _$_AddTournamentModel.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  PlayerPersonalInfo get organizer;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  String get logoUri;
  @override
  String get bannerUri;
  @override
  List<dynamic>? get teams;
  @override
  @JsonKey(ignore: true)
  _$$_AddTournamentModelCopyWith<_$_AddTournamentModel> get copyWith =>
      throw _privateConstructorUsedError;
}
