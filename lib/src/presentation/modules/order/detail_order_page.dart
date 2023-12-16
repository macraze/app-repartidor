import 'package:flutter/material.dart';
import 'package:app_repartidor/src/presentation/styles/styles.dart';
import 'package:app_repartidor/src/presentation/widgets/widgets.dart';

class DetailOrderPage extends StatelessWidget {
  const DetailOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context),
    );
  }

  Widget _getBody(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ContainerWidget(
      height: size.height * 1,
      decoration: const BoxDecoration(color: AppColors.backgroundGrey),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AppbarWidget(),
            // _buildBodyContainer(context),
          ],
        ),
      ),
    );
  }
}
