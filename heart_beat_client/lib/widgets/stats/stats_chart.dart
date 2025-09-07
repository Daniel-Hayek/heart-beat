import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat_client/core/constants/app_colors.dart';
import 'package:heart_beat_client/models/mood_tracking.dart';

class StatsChart extends StatelessWidget {
  final List<int> scores;
  final List<String> days;
  final List<MoodTracking> moods;

  const StatsChart({
    super.key,
    required this.scores,
    required this.days,
    required this.moods,
  });

  @override
  Widget build(BuildContext context) {
    final spots = List.generate(
      moods.length,
      (i) => FlSpot(i.toDouble(), moods[i].score.toDouble()),
    );

    // Generate the labels for the bottom axis
    final labels = moods
        .map((mood) => "${mood.timestamp.day}/${mood.timestamp.month}")
        .toList();

    return SizedBox.expand(
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 10,
          titlesData: FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();

                  if (index < 0 || index >= labels.length) return Container();
                  return Text(labels[index]);
                },
              ),
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              barWidth: 3,
              spots: spots,
              dotData: FlDotData(show: true),
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
