import 'package:flutter/material.dart';

import '../theme.dart';
import 'ds.dart';

/// Template "Header / 126" image composition: a tall image with a square
/// image overlapping its top-right corner.
class HeroImages extends StatelessWidget {
  const HeroImages({super.key, required this.large, required this.small});

  final String large;
  final String small;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final height = mobile ? 420.0 : 638.0;
    final inset = mobile ? 110.0 : 182.0;
    final square = mobile ? 190.0 : 304.0;
    final top = mobile ? 40.0 : 64.0;
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            right: inset,
            child: NetImage(large, radius: DsSpace.radius, alignment: const Alignment(0, -1)),
          ),
          Positioned(
            right: 0,
            top: top,
            width: square,
            height: square,
            child: NetImage(small, radius: DsSpace.radius, alignment: const Alignment(0, -0.5)),
          ),
        ],
      ),
    );
  }
}
