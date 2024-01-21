import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:app_repartidor/src/presentation/providers/providers.dart';
import 'package:app_repartidor/src/presentation/modules/order/order_page.dart';

class OrderTempPage extends StatefulWidget {
  const OrderTempPage({super.key});

  @override
  State<OrderTempPage> createState() => _OrderTempPageState();
}

class _OrderTempPageState extends State<OrderTempPage> {
  void initFunctions() async {
    final orderProvider =
        Provider.of<OrderTempProvider>(context, listen: false);
    orderProvider.setupSocketListeners();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => initFunctions());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OrderTempProvider>(
        builder: (context, provider, child) {
          if (provider.isShowCatWaiting) {
            return _buildWaitingView(); // Crear un widget para WaitingView
          } else if (provider.isShowOrderPending) {
            return _buildOrderPendingView(); // Crear un widget para OrderPendingView
          } else {
            return _buildOrderListView(); // Crear un widget para OrderListView
          }
        },
      ),
    );
  }

  Widget _buildWaitingView() {
    return const AssignOrderPage();
  }

  Widget _buildOrderPendingView() {
    return const OrderPendingPage();
  }

  Widget _buildOrderListView() {
    return const OrderListPage();
  }
}
