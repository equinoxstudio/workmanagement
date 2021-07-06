import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'details_record.g.dart';

abstract class DetailsRecord
    implements Built<DetailsRecord, DetailsRecordBuilder> {
  static Serializer<DetailsRecord> get serializer => _$detailsRecordSerializer;

  @nullable
  String get image;

  @nullable
  String get description;

  @nullable
  @BuiltValueField(wireName: 'project_cost')
  String get projectCost;

  @nullable
  String get tax;

  @nullable
  String get earning;

  @nullable
  String get gig;

  @nullable
  @BuiltValueField(wireName: 'due_date')
  String get dueDate;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(DetailsRecordBuilder builder) => builder
    ..image = ''
    ..description = ''
    ..projectCost = ''
    ..tax = ''
    ..earning = ''
    ..gig = ''
    ..dueDate = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('details');

  static Stream<DetailsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  DetailsRecord._();
  factory DetailsRecord([void Function(DetailsRecordBuilder) updates]) =
      _$DetailsRecord;

  static DetailsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createDetailsRecordData({
  String image,
  String description,
  String projectCost,
  String tax,
  String earning,
  String gig,
  String dueDate,
}) =>
    serializers.toFirestore(
        DetailsRecord.serializer,
        DetailsRecord((d) => d
          ..image = image
          ..description = description
          ..projectCost = projectCost
          ..tax = tax
          ..earning = earning
          ..gig = gig
          ..dueDate = dueDate));
