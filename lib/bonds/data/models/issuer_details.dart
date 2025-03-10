import 'package:freezed_annotation/freezed_annotation.dart';

part 'issuer_details.freezed.dart';
part 'issuer_details.g.dart';

@freezed
abstract class IssuerDetails with _$IssuerDetails {
  const factory IssuerDetails({
    @Default('-') @JsonKey(name: 'issuer_name') String issuerName,
    @Default('-') @JsonKey(name: 'type_of_issuer') String typeOfIssuer,
    @Default('-') String sector,
    @Default('-') String industry,
    @Default('-') @JsonKey(name: 'issuer_nature') String issuerNature,
    required String cin,
    @Default('-') @JsonKey(name: 'lead_manager') String leadManager,
    @Default('-') String registrar,
    @Default('-') @JsonKey(name: 'debenture_trustee') String debentureTrustee,
  }) = _IssuerDetails;

  factory IssuerDetails.fromJson(Map<String, dynamic> json) =>
      _$IssuerDetailsFromJson(json);
}
