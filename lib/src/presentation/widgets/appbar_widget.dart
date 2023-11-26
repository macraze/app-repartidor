import 'package:app_repartidor/src/presentation/styles/styles.dart';
import 'package:app_repartidor/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget with PreferredSizeWidget {
  const AppbarWidget({
    Key? key,
    required this.title,
    this.hasLeading = false,
    this.centerTitle = true,
    this.elevation = 0,
    this.backgroundColor = AppColors.primary,
    this.actions,
  }) : super(key: key);

  final String title;
  final bool? hasLeading;
  final bool? centerTitle;
  final double? elevation;
  final Color? backgroundColor;
  final List<Widget>? actions;

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      leading: !hasLeading!
          ? const ContainerWidget()
          : IconWidget(
              type: Type.icon,
              iconName: Icons.keyboard_arrow_left_rounded,
              onPressed: () => Navigator.of(context).pop(),
            ),
      title: TextWidget(
        text: title,
        fontSize: 15,
      ),
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: backgroundColor,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
