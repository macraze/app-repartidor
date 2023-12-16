import 'package:app_repartidor/src/data/local/local_storage.dart';
import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:app_repartidor/src/presentation/styles/styles.dart';
import 'package:app_repartidor/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({super.key, this.actions});

  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    final User user = userFromJson(LocalStorage.user);

    return ContainerWidget(
      decoration: const BoxDecoration(color: AppColors.primary),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      constraints: const BoxConstraints(minHeight: 96),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildUserInfo(user),
            actions ?? const ContainerWidget(),
          ],
        ),
      ),
    );
  }

  TextWidget _buildUserInfo(User user) {
    return TextWidget(
      text: user.nombre ?? '',
      fontSize: 13,
      maxLines: 2,
    );
  }
}
