import 'package:flutter/material.dart';
import 'package:my_productive_rewards/components/components.dart';
import 'package:my_productive_rewards/themes/themes.dart';

class MPRPointsHeader extends StatelessWidget {
  final String points;
  final String topText;
  final String bottomText;
  const MPRPointsHeader({
    super.key,
    required this.points,
    required this.topText,
    required this.bottomText,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ColorPalette.green.shade100,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    points,
                    style: MPRTextStyles.extraLargeSemiBold.copyWith(
                      fontSize: 65,
                      height: 1,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(topText, style: MPRTextStyles.regularBold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1.0),
                      child: Text(bottomText, style: MPRTextStyles.regularBold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          MPRDivider(),
        ],
      ),
    );
  }
}
