import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'journal_model.freezed.dart';
part 'journal_model.g.dart';

@freezed
abstract class JournalModel with _$JournalModel {
  const factory JournalModel({
    int? journalEntryId,
    required String entryText,
    DateTime? createdDateTime,
    DateTime? lastUpdatedDateTime,
    required List<int> petIdList,
    required List<String> tags,
  }) = _JournalModel;

  factory JournalModel.fromJson(Map<String, Object?> json) =>
      _$JournalModelFromJson(json);
}
