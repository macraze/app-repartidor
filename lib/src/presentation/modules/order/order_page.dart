import 'package:app_repartidor/src/presentation/modules/order/assign-order/assign_order_by_code_page.dart';
import 'package:app_repartidor/src/presentation/modules/order/order-list/order_list_page.dart';
import 'package:app_repartidor/src/presentation/modules/order/order-pending/order_pending_page.dart';
import 'package:app_repartidor/src/presentation/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  void initFunctions() async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
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
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) {
          if (provider.hasAcceptedOrdersStored) {
            return _buildAcceptedOrdersView(); // Crear un widget para la lista de pedidos aceptados
          } else if (provider.existOrderPending) {
            return _buildOrderPendingView(); // Widget existente para OrderPendingView
          } else {
            return _buildAssignOrder(); // Widget existente para OrderListView
          }
        },
      ),
    );
  }

  Widget _buildAcceptedOrdersView() {
    return OrderListPage();
  }

  Widget _buildOrderPendingView() {
    return OrderPendingPage();
  }

  Widget _buildAssignOrder() {
    return AssignOrderByCodePage();
  }
}
