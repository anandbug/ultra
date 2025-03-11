import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ultra/bonds/data/models/company_financial.dart';
import 'package:ultra/bonds/data/models/financial_data.dart';
import 'package:ultra/bonds/data/models/financials.dart';
import 'package:ultra/utils/app_colors.dart';
import 'package:ultra/utils/app_text_styles.dart';
import 'dart:ui' as ui;

class BarChart extends StatelessWidget {
  final bool isRevenue;
  final Financials companyFinancials;
  const BarChart({
    super.key,
    this.isRevenue = false,
    required this.companyFinancials,
  });

  List<CompanyFinancials> getCompanyFinancials() {
    final financialData = <CompanyFinancials>[];
    for (FinancialData editda in companyFinancials.ebitda) {
      final revenue = companyFinancials.revenue.firstWhere(
        (element) => element.month == editda.month,
      );
      financialData.add(
        CompanyFinancials(
          month: editda.month,
          ebitda: editda.value,
          revenue: revenue.value,
        ),
      );
    }
    return financialData;
  }

  @override
  Widget build(BuildContext context) {
    final financialData = getCompanyFinancials();
    int maxValue = financialData
        .map((f) => [f.ebitda, f.revenue].reduce((a, b) => a > b ? a : b))
        .reduce((a, b) => a > b ? a : b);
    int decimalPlace = (log(maxValue) / ln10).round();
    final double valueWithoutDecimal = maxValue / pow(10, decimalPlace - 1);
    maxValue = (valueWithoutDecimal.ceil()) * pow(10, decimalPlace - 1).toInt();

    final yLabels = getYLables(maxValue, decimalPlace);

    return AspectRatio(
      aspectRatio: 2,
      child: CustomPaint(
        painter: _BarChartPainter(financialData, maxValue, yLabels, isRevenue),
      ),
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final List<CompanyFinancials> financials;
  final int maxValue;
  final List<String> yLabels;
  final bool isRevenue;

  _BarChartPainter(
    this.financials,
    this.maxValue,
    this.yLabels,
    this.isRevenue,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final mapStartX = 40.0;
    final mapStartY = 20.0;
    final barWidth = (size.width - mapStartX) / (financials.length * 2);
    final mapHeight = size.height - mapStartY;

    final paint = Paint()..style = PaintingStyle.fill;

    paint
      ..color = AppColors.grey
      ..strokeWidth = 0.6;
    canvas.drawLine(
      Offset(mapStartX, mapHeight),
      Offset(size.width, mapHeight),
      paint,
    );

    // Draw Y-axis labels (₹ values)
    final yStep = (mapHeight) / yLabels.length;
    for (int i = 0; i < yLabels.length; i++) {
      final isEven = (i + 1) % 2 == 0;
      final y = mapHeight - (yStep * (i + 1));
      paint
        ..color = AppColors.grey.withValues(alpha: isEven ? 1 : 0.2)
        ..strokeWidth = 0.6;
      canvas.drawLine(Offset(mapStartX, y), Offset(size.width, y), paint);
      if (isEven) {
        final textSpan = TextSpan(
          text: yLabels[i],
          style: AppTextStyles.body1.copyWith(color: AppColors.textGrey),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: ui.TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(0, y - 8));
      }
    }

    for (int i = 0; i < financials.length; i++) {
      final financial = financials[i];
      final x = i * (barWidth * 2) + mapStartX;

      // Draw X-axis labels (months)
      final textSpan = TextSpan(
        text: financials[i].month[0].toUpperCase(),
        style: AppTextStyles.body1.copyWith(color: AppColors.textGrey),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: ui.TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x + barWidth / 2 - 2, mapHeight + 5));

      // Draw Revenue (light blue)
      paint.color = isRevenue ? AppColors.blue : AppColors.blueBG;
      final revenueHeight = (financial.revenue / maxValue) * mapHeight;
      canvas.drawRRect(
        RRect.fromLTRBR(
          x,
          mapHeight - revenueHeight,
          x + barWidth,
          mapHeight,
          Radius.circular(2), // Corner Radius
        ),
        paint,
      );

      if (!isRevenue) {
        // Draw EBITDA (black)
        paint.color = AppColors.ebitdaBlack;
        final ebitdaHeight = (financial.ebitda / maxValue) * mapHeight;
        canvas.drawRRect(
          RRect.fromLTRBR(
            x,
            mapHeight - ebitdaHeight,
            x + barWidth,
            mapHeight,
            Radius.circular(2),
          ),
          paint,
        );
      }
    }

    // Draw vertical line for 2024/2025
    paint
      ..color = AppColors.titleGrey
      ..strokeWidth = 0.6;
    final xValue = 7 * barWidth + barWidth / 2 + mapStartX;
    const dashWidth = 5.0;
    const dashSpace = 3.0;
    double startY = 0;
    while (startY < size.height - 20) {
      canvas.drawLine(
        Offset(xValue, startY),
        Offset(xValue, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }

    //draw text 2024 ! 2025
    final textSpan = TextSpan(
      text: "2024    2025",
      style: AppTextStyles.body1.copyWith(color: AppColors.textGrey),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: ui.TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(xValue - 30, 0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

List<String> getYLables(int maxValue, int maxDecimalPlace) {
  List<String> yLabels = [];
  double graphMaxHeight = maxValue / pow(10, maxDecimalPlace);
  double startValue = 0.0;
  while (graphMaxHeight - 0.5 >= 0) {
    graphMaxHeight = graphMaxHeight - 0.5;
    startValue = startValue + 0.5 * pow(10, maxDecimalPlace - 1);
    final value = NumberFormat.compactCurrency(
      locale: 'en_IN',
      symbol: "₹",
    ).format(startValue);
    yLabels.add(value);
  }
  return yLabels;
}
