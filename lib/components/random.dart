import 'dart:math';

class RandomWrapper with Random {
  final Random me = new Random();

  int generateRandomAbove(int above, int max) {
    int gen = me.nextInt(max - above);
    return above + gen;
  }

  double generateRandomDecimalToPointTwentyFive() {
    return me.nextInt(85000) / (85001 * 4);
  }

  @override
  bool nextBool() {
    return me.nextBool();
  }

  @override
  double nextDouble() {
    return me.nextDouble();
  }

  @override
  int nextInt(int max) {
    return me.nextInt(max);
  }
}
