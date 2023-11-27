import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app_repartidor/src/presentation/styles/styles.dart';
import 'package:app_repartidor/src/presentation/widgets/widgets.dart';
import 'package:app_repartidor/src/presentation/common/constants/constants.dart';

enum Type { image, icon }

enum IconType {
  logo,
}

class IconWidget extends StatelessWidget {
  const IconWidget({
    Key? key,
    required this.type,
    this.name,
    this.iconName,
    this.text = '',
    this.onPressed,
    this.color = Colors.white,
    this.size = 10,
    this.fontSize = 10,
    // this.height = 10,
    // this.width = 10,
    // this.heightIcon = 10,
    // this.widthIcon = 10,
    this.decoration,
    this.decorationIcon,
    this.padding = EdgeInsets.zero,
    this.paddingIcon = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.marginIcon = EdgeInsets.zero,
    this.style,
    this.fontWeight,
    this.textAlign,
    this.mainAxisSize = MainAxisSize.max,
  }) : super(key: key);

  final Type? type;
  final IconType? name;
  final IconData? iconName;
  final String? text;
  final void Function()? onPressed;
  final Color? color;
  final double? size;
  final double? fontSize;
  // final double? height;
  // final double? width;
  // final double? heightIcon;
  // final double? widthIcon;
  final Decoration? decoration;
  final Decoration? decorationIcon;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? paddingIcon;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? marginIcon;
  final TextStyle? style;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      minSize: 0,
      child: ContainerWidget(
        // height: height,
        // width: width,
        decoration: decoration,
        padding: padding,
        margin: margin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: mainAxisSize,
          children: [
            _getIcon(),
            text!.isEmpty ? const ContainerWidget() : const SizedBox(width: 4),
            _getTitle(),
          ],
        ),
      ),
    );
  }

  Widget _getIcon() {
    if (type == Type.image) {
      return ContainerWidget(
        decoration: decorationIcon,
        padding: paddingIcon,
        margin: marginIcon,
        child: Image(
          height: size,
          width: size,
          // placeholder: AssetImage('assets/icons/meditation/like_icon.png'),
          image: AssetImage(icon()),
          fit: BoxFit.fitHeight,
          color: color,
        ),
      );
    }

    return ContainerWidget(
        decoration: decorationIcon,
        padding: paddingIcon,
        margin: marginIcon,
        child: Icon(iconName, size: (size! + 0.5), color: color));
  }

  Widget _getTitle() {
    if (text!.isEmpty) {
      return const ContainerWidget();
    }

    return ContainerWidget(
      child: TextWidget(
        text: text!,
        fontSize: fontSize,
        style: style,
        color: AppColors.textColor,
        fontWeight: fontWeight,
        textAlign: textAlign,
      ),
    );
  }

  String icon() {
    switch (name) {
      case IconType.logo:
        return IconConstant.logoHappyMusic;
      default:
        return IconConstant.logoHappyMusic;
    }
  }
}
