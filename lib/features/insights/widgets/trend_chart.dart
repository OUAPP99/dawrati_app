import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Interactive line chart for a daily metric (water, sleep, mood...).
/// Shows real dates on the x-axis and a tooltip with the exact value on tap.
class TrendChart extends StatelessWidget {
  final List<DateTime> dates;
  final List<double> values;
  final Color color;
  final String Function(double value) valueLabel;
  final double minY;
  final double maxY;
  final String Function(double value)? leftAxisLabel;
  final String noDataLabel;

  const TrendChart({
    super.key,
    required this.dates,
    required this.values,
    required this.color,
    required this.valueLabel,
    required this.minY,
    required this.maxY,
    required this.noDataLabel,
    this.leftAxisLabel,
  });

  @override
  Widget build(BuildContext context) {
    if (dates.isEmpty) {
      return SizedBox(
        height: 180,
        child: Center(
          child: Text(
            noDataLabel,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    final locale = Localizations.localeOf(context).toString();
    final spots = List.generate(
      values.length,
      (i) => FlSpot(i.toDouble(), values[i]),
    );

    final labelEvery = (dates.length / 5).ceil().clamp(1, dates.length);

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          minY: minY,
          maxY: maxY,
          gridData: FlGridData(
            drawVerticalLine: false,
            horizontalInterval: (maxY - minY) / 4 == 0 ? 1 : (maxY - minY) / 4,
            getDrawingHorizontalLine: (_) => FlLine(
              color: Colors.grey.shade200,
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 34,
                interval: (maxY - minY) / 4 == 0 ? 1 : (maxY - minY) / 4,
                getTitlesWidget: (value, meta) => Text(
                  leftAxisLabel != null ? leftAxisLabel!(value) : value.toStringAsFixed(0),
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 26,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= dates.length) return const SizedBox.shrink();
                  if (index % labelEvery != 0 && index != dates.length - 1) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      DateFormat.Md(locale).format(dates[index]),
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                    ),
                  );
                },
              ),
            ),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => color,
              getTooltipItems: (touchedSpots) => touchedSpots.map((spot) {
                final index = spot.x.toInt();
                final date = index >= 0 && index < dates.length ? dates[index] : null;
                final dateStr = date != null ? DateFormat.MMMd(locale).format(date) : '';
                return LineTooltipItem(
                  '$dateStr\n${valueLabel(spot.y)}',
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                );
              }).toList(),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.25,
              color: color,
              barWidth: 3,
              dotData: FlDotData(
                show: values.length <= 14,
                getDotPainter: (spot, percent, bar, index) =>
                    FlDotCirclePainter(radius: 3.5, color: color, strokeWidth: 2, strokeColor: Colors.white),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [color.withValues(alpha: .22), color.withValues(alpha: 0)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
