import 'package:flutter/material.dart';
import 'package:project_nash_equilibrium/components/random.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WavesBackground extends StatelessWidget {
  final List<Color> colors;

  WavesBackground(this.colors);

  @override
  Widget build(BuildContext context) {
    RandomWrapper r = new RandomWrapper();

    return WaveWidget(wavePhase: 2,
      waveFrequency: 1.3,
      config: CustomConfig(
        gradients: colors.map((c) => [c, c.withOpacity(0.8)]).toList(),
        durations:
            colors.map((c) => r.generateRandomAbove(6000, 6500)).toList(),
        blur: MaskFilter.blur(BlurStyle.inner, 5),
        heightPercentages: colors
            .map((c) => r.generateRandomDecimalToPointTwentyFive())
            .toList(),
        gradientBegin: Alignment.topCenter,
        gradientEnd: Alignment.bottomCenter,
      ),
      size: Size(1000, 145),
      waveAmplitude: 45,
      backgroundColor: Color(0xFF1C3853),
    );
  }
}
