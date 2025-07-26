// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JournalModel _$JournalModelFromJson(Map<String, dynamic> json) =>
    _JournalModel(
      journalEntryId: (json['journalEntryId'] as num?)?.toInt(),
      entryText: json['entryText'] as String,
      createdDateTime: json['createdDateTime'] == null
          ? null
          : DateTime.parse(json['createdDateTime'] as String),
      lastUpdatedDateTime: json['lastUpdatedDateTime'] == null
          ? null
          : DateTime.parse(json['lastUpdatedDateTime'] as String),
      petIdList: (json['petIdList'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$JournalModelToJson(_JournalModel instance) =>
    <String, dynamic>{
      'journalEntryId': instance.journalEntryId,
      'entryText': instance.entryText,
      'createdDateTime': instance.createdDateTime?.toIso8601String(),
      'lastUpdatedDateTime': instance.lastUpdatedDateTime?.toIso8601String(),
      'petIdList': instance.petIdList,
      'tags': instance.tags,
    };
