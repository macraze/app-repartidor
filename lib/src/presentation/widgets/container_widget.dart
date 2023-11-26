import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget(
      {super.key,
      this.margin,
      this.padding,
      this.decoration,
      this.width,
      this.height,
      this.constraints,
      this.child});

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Decoration? decoration;
  final Widget? child;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
            decoration:
                decoration ?? const BoxDecoration(color: Colors.transparent),
            child: ConstrainedBox(
                constraints: constraints ??
                    BoxConstraints.tightFor(width: width, height: height),
                child: Padding(
                    padding: padding ?? EdgeInsets.zero, child: child))),
      ),
    );
  }
}
