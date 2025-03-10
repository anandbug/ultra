import 'package:freezed_annotation/freezed_annotation.dart';

part 'pros_and_cons.freezed.dart';
part 'pros_and_cons.g.dart';

@freezed
abstract class ProsAndCons with _$ProsAndCons {
  const factory ProsAndCons({
    required List<String> pros,
    required List<String> cons,
  }) = _ProsAndCons;

  factory ProsAndCons.fromJson(Map<String, dynamic> json) =>
      _$ProsAndConsFromJson(json);
}
