import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsChart extends StatelessWidget {
  final List<int> scores;
  final List<String> days;

  const StatsChart({super.key, required this.scores, required this.days});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 10,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();

                  if (index < 0 || index >= days.length) return Container();
                  return Text(days[index]);
                },
              ),
            ),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              barWidth: 3,
              spots: List.generate(
                scores.length,
                (i) => FlSpot(i.toDouble(), scores[i].toDouble()),
              ),
              dotData: FlDotData(show: true),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
