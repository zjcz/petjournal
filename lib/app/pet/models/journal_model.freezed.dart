// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JournalModel implements DiagnosticableTreeMixin {

 int? get journalEntryId; String get entryText; DateTime? get createdDateTime; DateTime? get lastUpdatedDateTime; List<int> get petIdList; List<String> get tags; int? get linkedRecordId; LinkedRecordType? get linkedRecordType; String? get linkedRecordTitle;
/// Create a copy of JournalModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalModelCopyWith<JournalModel> get copyWith => _$JournalModelCopyWithImpl<JournalModel>(this as JournalModel, _$identity);

  /// Serializes this JournalModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'JournalModel'))
    ..add(DiagnosticsProperty('journalEntryId', journalEntryId))..add(DiagnosticsProperty('entryText', entryText))..add(DiagnosticsProperty('createdDateTime', createdDateTime))..add(DiagnosticsProperty('lastUpdatedDateTime', lastUpdatedDateTime))..add(DiagnosticsProperty('petIdList', petIdList))..add(DiagnosticsProperty('tags', tags))..add(DiagnosticsProperty('linkedRecordId', linkedRecordId))..add(DiagnosticsProperty('linkedRecordType', linkedRecordType))..add(DiagnosticsProperty('linkedRecordTitle', linkedRecordTitle));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalModel&&(identical(other.journalEntryId, journalEntryId) || other.journalEntryId == journalEntryId)&&(identical(other.entryText, entryText) || other.entryText == entryText)&&(identical(other.createdDateTime, createdDateTime) || other.createdDateTime == createdDateTime)&&(identical(other.lastUpdatedDateTime, lastUpdatedDateTime) || other.lastUpdatedDateTime == lastUpdatedDateTime)&&const DeepCollectionEquality().equals(other.petIdList, petIdList)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.linkedRecordId, linkedRecordId) || other.linkedRecordId == linkedRecordId)&&(identical(other.linkedRecordType, linkedRecordType) || other.linkedRecordType == linkedRecordType)&&(identical(other.linkedRecordTitle, linkedRecordTitle) || other.linkedRecordTitle == linkedRecordTitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,journalEntryId,entryText,createdDateTime,lastUpdatedDateTime,const DeepCollectionEquality().hash(petIdList),const DeepCollectionEquality().hash(tags),linkedRecordId,linkedRecordType,linkedRecordTitle);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'JournalModel(journalEntryId: $journalEntryId, entryText: $entryText, createdDateTime: $createdDateTime, lastUpdatedDateTime: $lastUpdatedDateTime, petIdList: $petIdList, tags: $tags, linkedRecordId: $linkedRecordId, linkedRecordType: $linkedRecordType, linkedRecordTitle: $linkedRecordTitle)';
}


}

/// @nodoc
abstract mixin class $JournalModelCopyWith<$Res>  {
  factory $JournalModelCopyWith(JournalModel value, $Res Function(JournalModel) _then) = _$JournalModelCopyWithImpl;
@useResult
$Res call({
 int? journalEntryId, String entryText, DateTime? createdDateTime, DateTime? lastUpdatedDateTime, List<int> petIdList, List<String> tags, int? linkedRecordId, LinkedRecordType? linkedRecordType, String? linkedRecordTitle
});




}
/// @nodoc
class _$JournalModelCopyWithImpl<$Res>
    implements $JournalModelCopyWith<$Res> {
  _$JournalModelCopyWithImpl(this._self, this._then);

  final JournalModel _self;
  final $Res Function(JournalModel) _then;

/// Create a copy of JournalModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? journalEntryId = freezed,Object? entryText = null,Object? createdDateTime = freezed,Object? lastUpdatedDateTime = freezed,Object? petIdList = null,Object? tags = null,Object? linkedRecordId = freezed,Object? linkedRecordType = freezed,Object? linkedRecordTitle = freezed,}) {
  return _then(_self.copyWith(
journalEntryId: freezed == journalEntryId ? _self.journalEntryId : journalEntryId // ignore: cast_nullable_to_non_nullable
as int?,entryText: null == entryText ? _self.entryText : entryText // ignore: cast_nullable_to_non_nullable
as String,createdDateTime: freezed == createdDateTime ? _self.createdDateTime : createdDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdatedDateTime: freezed == lastUpdatedDateTime ? _self.lastUpdatedDateTime : lastUpdatedDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,petIdList: null == petIdList ? _self.petIdList : petIdList // ignore: cast_nullable_to_non_nullable
as List<int>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,linkedRecordId: freezed == linkedRecordId ? _self.linkedRecordId : linkedRecordId // ignore: cast_nullable_to_non_nullable
as int?,linkedRecordType: freezed == linkedRecordType ? _self.linkedRecordType : linkedRecordType // ignore: cast_nullable_to_non_nullable
as LinkedRecordType?,linkedRecordTitle: freezed == linkedRecordTitle ? _self.linkedRecordTitle : linkedRecordTitle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _JournalModel with DiagnosticableTreeMixin implements JournalModel {
  const _JournalModel({this.journalEntryId, required this.entryText, this.createdDateTime, this.lastUpdatedDateTime, required final  List<int> petIdList, required final  List<String> tags, this.linkedRecordId, this.linkedRecordType, this.linkedRecordTitle}): _petIdList = petIdList,_tags = tags;
  factory _JournalModel.fromJson(Map<String, dynamic> json) => _$JournalModelFromJson(json);

@override final  int? journalEntryId;
@override final  String entryText;
@override final  DateTime? createdDateTime;
@override final  DateTime? lastUpdatedDateTime;
 final  List<int> _petIdList;
@override List<int> get petIdList {
  if (_petIdList is EqualUnmodifiableListView) return _petIdList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_petIdList);
}

 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  int? linkedRecordId;
@override final  LinkedRecordType? linkedRecordType;
@override final  String? linkedRecordTitle;

/// Create a copy of JournalModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalModelCopyWith<_JournalModel> get copyWith => __$JournalModelCopyWithImpl<_JournalModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JournalModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'JournalModel'))
    ..add(DiagnosticsProperty('journalEntryId', journalEntryId))..add(DiagnosticsProperty('entryText', entryText))..add(DiagnosticsProperty('createdDateTime', createdDateTime))..add(DiagnosticsProperty('lastUpdatedDateTime', lastUpdatedDateTime))..add(DiagnosticsProperty('petIdList', petIdList))..add(DiagnosticsProperty('tags', tags))..add(DiagnosticsProperty('linkedRecordId', linkedRecordId))..add(DiagnosticsProperty('linkedRecordType', linkedRecordType))..add(DiagnosticsProperty('linkedRecordTitle', linkedRecordTitle));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JournalModel&&(identical(other.journalEntryId, journalEntryId) || other.journalEntryId == journalEntryId)&&(identical(other.entryText, entryText) || other.entryText == entryText)&&(identical(other.createdDateTime, createdDateTime) || other.createdDateTime == createdDateTime)&&(identical(other.lastUpdatedDateTime, lastUpdatedDateTime) || other.lastUpdatedDateTime == lastUpdatedDateTime)&&const DeepCollectionEquality().equals(other._petIdList, _petIdList)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.linkedRecordId, linkedRecordId) || other.linkedRecordId == linkedRecordId)&&(identical(other.linkedRecordType, linkedRecordType) || other.linkedRecordType == linkedRecordType)&&(identical(other.linkedRecordTitle, linkedRecordTitle) || other.linkedRecordTitle == linkedRecordTitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,journalEntryId,entryText,createdDateTime,lastUpdatedDateTime,const DeepCollectionEquality().hash(_petIdList),const DeepCollectionEquality().hash(_tags),linkedRecordId,linkedRecordType,linkedRecordTitle);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'JournalModel(journalEntryId: $journalEntryId, entryText: $entryText, createdDateTime: $createdDateTime, lastUpdatedDateTime: $lastUpdatedDateTime, petIdList: $petIdList, tags: $tags, linkedRecordId: $linkedRecordId, linkedRecordType: $linkedRecordType, linkedRecordTitle: $linkedRecordTitle)';
}


}

/// @nodoc
abstract mixin class _$JournalModelCopyWith<$Res> implements $JournalModelCopyWith<$Res> {
  factory _$JournalModelCopyWith(_JournalModel value, $Res Function(_JournalModel) _then) = __$JournalModelCopyWithImpl;
@override @useResult
$Res call({
 int? journalEntryId, String entryText, DateTime? createdDateTime, DateTime? lastUpdatedDateTime, List<int> petIdList, List<String> tags, int? linkedRecordId, LinkedRecordType? linkedRecordType, String? linkedRecordTitle
});




}
/// @nodoc
class __$JournalModelCopyWithImpl<$Res>
    implements _$JournalModelCopyWith<$Res> {
  __$JournalModelCopyWithImpl(this._self, this._then);

  final _JournalModel _self;
  final $Res Function(_JournalModel) _then;

/// Create a copy of JournalModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? journalEntryId = freezed,Object? entryText = null,Object? createdDateTime = freezed,Object? lastUpdatedDateTime = freezed,Object? petIdList = null,Object? tags = null,Object? linkedRecordId = freezed,Object? linkedRecordType = freezed,Object? linkedRecordTitle = freezed,}) {
  return _then(_JournalModel(
journalEntryId: freezed == journalEntryId ? _self.journalEntryId : journalEntryId // ignore: cast_nullable_to_non_nullable
as int?,entryText: null == entryText ? _self.entryText : entryText // ignore: cast_nullable_to_non_nullable
as String,createdDateTime: freezed == createdDateTime ? _self.createdDateTime : createdDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdatedDateTime: freezed == lastUpdatedDateTime ? _self.lastUpdatedDateTime : lastUpdatedDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,petIdList: null == petIdList ? _self._petIdList : petIdList // ignore: cast_nullable_to_non_nullable
as List<int>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,linkedRecordId: freezed == linkedRecordId ? _self.linkedRecordId : linkedRecordId // ignore: cast_nullable_to_non_nullable
as int?,linkedRecordType: freezed == linkedRecordType ? _self.linkedRecordType : linkedRecordType // ignore: cast_nullable_to_non_nullable
as LinkedRecordType?,linkedRecordTitle: freezed == linkedRecordTitle ? _self.linkedRecordTitle : linkedRecordTitle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
