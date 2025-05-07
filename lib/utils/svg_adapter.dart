import 'package:flutter_svg/svg.dart';

class SvgAdapter extends SvgPicture {
  SvgAdapter.asset(
    super.assetName, {
    super.key,
    super.color,
    super.width,
    super.height,
    super.semanticsLabel,
  }) : super.asset();
}
