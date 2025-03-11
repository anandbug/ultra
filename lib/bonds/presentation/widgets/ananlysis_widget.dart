import 'package:flutter/material.dart';
import 'package:ultra/bonds/data/models/company_details_model.dart';
import 'package:ultra/bonds/presentation/widgets/company_financials_widget.dart';
import 'package:ultra/bonds/presentation/widgets/issuers_details_widget.dart';
import 'package:ultra/utils/num_extensions.dart';

class AnanlysisWidget extends StatelessWidget {
  final CompanyDetailsModel data;
  const AnanlysisWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        12.sh,
        CompanyFinancialsWidget(data: data.financials),
        24.sh,
        IssuerDetailsWidget(data: data.issuerDetails),
        40.sh,
      ],
    );
  }
}
