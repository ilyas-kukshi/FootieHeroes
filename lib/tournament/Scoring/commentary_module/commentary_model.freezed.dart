// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'commentary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CommentaryModel _$CommentaryModelFromJson(Map<String, dynamic> json) {
  return _CommentaryModel.fromJson(json);
}

/// @nodoc
mixin _$CommentaryModel {
  String? get id => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get commentary => throw _privateConstructorUsedError;
  int get minute => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentaryModelCopyWith<CommentaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentaryModelCopyWith<$Res> {
  factory $CommentaryModelCopyWith(
          CommentaryModel value, $Res Function(CommentaryModel) then) =
      _$CommentaryModelCopyWithImpl<$Res, CommentaryModel>;
  @useResult
  $Res call({String? id, DateTime timestamp, String commentary, int minute});
}

/// @nodoc
class _$CommentaryModelCopyWithImpl<$Res, $Val extends CommentaryModel>
    implements $CommentaryModelCopyWith<$Res> {
  _$CommentaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? timestamp = null,
    Object? commentary = null,
    Object? minute = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      commentary: null == commentary
          ? _value.commentary
          : commentary // ignore: cast_nullable_to_non_nullable
              as String,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CommentaryModelCopyWith<$Res>
    implements $CommentaryModelCopyWith<$Res> {
  factory _$$_CommentaryModelCopyWith(
          _$_CommentaryModel value, $Res Function(_$_CommentaryModel) then) =
      __$$_CommentaryModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, DateTime timestamp, String commentary, int minute});
}

/// @nodoc
class __$$_CommentaryModelCopyWithImpl<$Res>
    extends _$CommentaryModelCopyWithImpl<$Res, _$_CommentaryModel>
    implements _$$_CommentaryModelCopyWith<$Res> {
  __$$_CommentaryModelCopyWithImpl(
      _$_CommentaryModel _value, $Res Function(_$_CommentaryModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? timestamp = null,
    Object? commentary = null,
    Object? minute = null,
  }) {
    return _then(_$_CommentaryModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      commentary: null == commentary
          ? _value.commentary
          : commentary // ignore: cast_nullable_to_non_nullable
              as String,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CommentaryModel extends _CommentaryModel {
  _$_CommentaryModel(
      {this.id,
      required this.timestamp,
      required this.commentary,
      required this.minute})
      : super._();

  factory _$_CommentaryModel.fromJson(Map<String, dynamic> json) =>
      _$$_CommentaryModelFromJson(json);

  @override
  final String? id;
  @override
  final DateTime timestamp;
  @override
  final String commentary;
  @override
  final int minute;

  @override
  String toString() {
    return 'CommentaryModel(id: $id, timestamp: $timestamp, commentary: $commentary, minute: $minute)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CommentaryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.commentary, commentary) ||
                other.commentary == commentary) &&
            (identical(other.minute, minute) || other.minute == minute));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, timestamp, commentary, minute);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CommentaryModelCopyWith<_$_CommentaryModel> get copyWith =>
      __$$_CommentaryModelCopyWithImpl<_$_CommentaryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommentaryModelToJson(
      this,
    );
  }
}

abstract class _CommentaryModel extends CommentaryModel {
  factory _CommentaryModel(
      {final String? id,
      required final DateTime timestamp,
      required final String commentary,
      required final int minute}) = _$_CommentaryModel;
  _CommentaryModel._() : super._();

  factory _CommentaryModel.fromJson(Map<String, dynamic> json) =
      _$_CommentaryModel.fromJson;

  @override
  String? get id;
  @override
  DateTime get timestamp;
  @override
  String get commentary;
  @override
  int get minute;
  @override
  @JsonKey(ignore: true)
  _$$_CommentaryModelCopyWith<_$_CommentaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}
