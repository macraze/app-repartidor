import 'dart:io';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:app_repartidor/src/domain/models/models.dart';
import 'package:app_repartidor/src/presentation/styles/styles.dart';
import 'package:app_repartidor/src/presentation/widgets/widgets.dart';
import 'package:app_repartidor/src/presentation/providers/providers.dart';
import 'package:app_repartidor/src/presentation/common/utils/snackbars.dart';

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
            _buidAppbar(context),
            _buildBody(context),
            // _buildBodyContainer(context),
          ],
        ),
      ),
    );
  }

  AppbarWidget _buidAppbar(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final Order order = orderProvider.orderDetailSelected;

    return AppbarWidget(
      leading: TextWidget(
        text: 'Pedido #${order.idpedido}',
        fontSize: 15,
      ),
      actions: IconWidget(
        type: Type.icon,
        iconName: Icons.close,
        size: 20,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ContainerWidget(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildComercio(context),
          _buildCliente(context),
          const Divider(height: 50),
          _buildDetailOrder(context),
          const Divider(height: 50),
          _buildButtons(context),
        ],
      ),
    );
  }

  Widget _buildComercio(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final Order order = orderProvider.orderDetailSelected;
    final JsonDatosDelivery delivery = order.jsonDatosDelivery!.isNotEmpty
        ? jsonOneDatosDeliveryFromJson(order.jsonDatosDelivery!)
        : JsonDatosDelivery();

    bool isRepartidorPropio = UserProvider().isRepartidorPropio;

    if (!isRepartidorPropio) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(text: 'Comercio', color: Colors.black),
          TextWidget(
              text:
                  '${delivery.pHeader?.arrDatosDelivery?.establecimiento?.nombre}',
              color: Colors.black),
          TextWidget(
              text:
                  '${delivery.pHeader?.arrDatosDelivery?.establecimiento?.direccion}',
              color: Colors.black),
          TextWidget(
              text:
                  '${delivery.pHeader?.arrDatosDelivery?.establecimiento?.telefono}',
              color: Colors.black),
          const SizedBox(height: 20),
          Row(
            children: [
              ButtonWidget(
                  text: 'Muéstrame camino',
                  onPressed: () {
                    showCamino(false, delivery);
                  }),
              const SizedBox(width: 10),
              ButtonWidget(
                text: 'Llamar',
                onPressed: () {
                  callPhone(
                      phone: delivery.pHeader?.arrDatosDelivery?.establecimiento
                              ?.telefono ??
                          '');
                },
                color: Colors.black54,
              )
            ],
          )
        ],
      );
    }

    return const ContainerWidget();
  }

  Widget _buildCliente(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final Order order = orderProvider.orderDetailSelected;
    final JsonDatosDelivery delivery = order.jsonDatosDelivery!.isNotEmpty
        ? jsonOneDatosDeliveryFromJson(order.jsonDatosDelivery!)
        : JsonDatosDelivery();

    final bool isDireccionGeoreferenciada =
        delivery.pHeader?.arrDatosDelivery?.direccionEnvioSelected?.latitude !=
                null
            ? true
            : false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
          text: 'Cliente',
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        const SizedBox(height: 5),
        TextWidget(
          text: '${delivery.pHeader?.arrDatosDelivery?.nombres}',
          color: Colors.black,
          fontSize: 14,
        ),
        TextWidget(
          text: '${delivery.pHeader?.arrDatosDelivery?.direccion}',
          color: Colors.black,
          fontWeight: FontWeight.w300,
          fontSize: 13,
        ),
        const SizedBox(height: 5),
        TextWidget(
          text: '${delivery.pHeader?.arrDatosDelivery?.referencia}',
          color: Colors.black,
          fontSize: 13,
        ),
        const SizedBox(height: 3),
        if (!isDireccionGeoreferenciada)
          const TextWidget(
              text: "Direccion no Georeferenciada", color: Colors.red),
        if (!isDireccionGeoreferenciada) const SizedBox(height: 3),
        TextWidget(
          text: '${delivery.pHeader?.arrDatosDelivery?.telefono}',
          color: Colors.blue,
          fontSize: 13,
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              if (isDireccionGeoreferenciada)
                ButtonWidget(
                    text: 'Muéstrame camino',
                    onPressed: () {
                      showCamino(true, delivery);
                    }),
              if (isDireccionGeoreferenciada) const SizedBox(width: 10),
              ButtonWidget(
                text: 'Llamar',
                onPressed: () {
                  callPhone(
                      phone:
                          delivery.pHeader?.arrDatosDelivery?.telefono ?? '');
                },
                color: Colors.black54,
              ),
              const SizedBox(width: 10),
              ButtonWidget(
                text: 'Whatsapp',
                onPressed: () {
                  goToWhatsapp(
                      phone:
                          delivery.pHeader?.arrDatosDelivery?.telefono ?? '');
                },
                color: Colors.green,
              )
            ],
          ),
        )
      ],
    );
  }

  void goToWhatsapp({required String phone}) async {
    String url = '';
    if (Platform.isAndroid) {
      url = "https://wa.me/$phone";
    } else {
      url = "https://api.whatsapp.com/send?phone=$phone";
    }

    final parsePhone = Uri.parse(url);

    if (await canLaunchUrl(parsePhone)) {
      launchUrl(parsePhone, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildDetailOrder(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final Order order = orderProvider.orderDetailSelected;
    final JsonDatosDelivery delivery = order.jsonDatosDelivery!.isNotEmpty
        ? jsonOneDatosDeliveryFromJson(order.jsonDatosDelivery!)
        : JsonDatosDelivery();

    final String total = order.totalR ?? order.total ?? '0.00';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
          text: 'El Pedido',
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: delivery.pBody?.tipoconsumo?[0].secciones?.length,
          itemBuilder: (context, index) {
            final Seccione seccion =
                delivery.pBody?.tipoconsumo?[0].secciones?[index] ?? Seccione();
            return ContainerWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContainerWidget(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.grey[600]),
                    padding: const EdgeInsets.all(10),
                    child: TextWidget(
                      text: seccion.des ?? '',
                      color: Colors.white,
                      textAlign: TextAlign.start,
                      fontSize: 14,
                    ),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: seccion.items?.length,
                    itemBuilder: (context, index) {
                      final Item item = seccion.items?[index] ?? Item();
                      return ContainerWidget(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(color: Colors.grey[300]!),
                            right: BorderSide(color: Colors.grey[300]!),
                            bottom: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: '${item.cantidadSeleccionada}',
                              color: Colors.black,
                              fontSize: 13,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                                child: TextWidget(
                              text: '${item.des}',
                              textAlign: TextAlign.start,
                              color: Colors.black,
                              fontSize: 13,
                            )),
                            TextWidget(
                              text: '${item.precioPrint}',
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
        ContainerWidget(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.grey[600]),
          padding: const EdgeInsets.all(10),
          child: const TextWidget(
            text: 'TOTALES',
            color: Colors.white,
            textAlign: TextAlign.start,
            fontSize: 14,
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: delivery.pSubtotales?.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final PSubtotale subtotal =
                delivery.pSubtotales?[index] ?? PSubtotale();
            if (subtotal.visible ?? false) {
              return ContainerWidget(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border(
                    left: BorderSide(color: Colors.grey[300]!),
                    right: BorderSide(color: Colors.grey[300]!),
                    bottom: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: '${subtotal.descripcion}',
                      color: Colors.black,
                      fontSize: 13,
                    ),
                    TextWidget(
                      text: '${subtotal.importe}',
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ],
                ),
              );
            }

            return const Center();
          },
        ),
        ContainerWidget(
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextWidget(
                text: 'COSTO DE PRODUCTOS',
                color: Colors.white,
                fontSize: 14,
              ),
              TextWidget(
                text: '${order.totalPagaRepartidor?.toStringAsFixed(2)}',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const TextWidget(
                    text: 'Costo de Entrega',
                    color: Colors.black,
                    fontSize: 12),
                TextWidget(
                  text: '${order.costoDelivery?.toStringAsFixed(2)}',
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                )
              ],
            ),
            Column(
              children: [
                const TextWidget(
                    text: 'Propina', color: Colors.black, fontSize: 12),
                TextWidget(
                  text: '${order.propinaRepartidor?.toStringAsFixed(2)}',
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                )
              ],
            ),
            Column(
              children: [
                const TextWidget(
                    text: 'Cliente paga', color: Colors.black, fontSize: 12),
                TextWidget(
                  text: total,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                )
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final socketProvider = Provider.of<SocketProvider>(context);
    final Order order = orderProvider.orderDetailSelected;

    if (order.pwaEstado == 'E') {
      return ContainerWidget(
        width: double.infinity,
        child: Column(
          children: [
            const TextWidget(
                text: 'Pedido entregado', color: Colors.green, fontSize: 13),
            const SizedBox(height: 10),
            ButtonWidget(
                text: 'Cerrar',
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonWidget(
            text: 'Listo Entregado!',
            onPressed: () async {
              final response = await orderProvider.updateToPedidoEntregado();

              if (response != null) {
                Snackbars.showSnackbarError(response);
              } else {
                socketProvider.updateToPedidoEntregado(order: order);
                Snackbars.showSnackbarSuccess(
                    'El pedido ha sido entregado con éxito!');
              }
            },
            loading: orderProvider.isLoadingOrderDeliveredFinish,
            disabled: orderProvider.isLoadingOrderDeliveredFinish,
            color: Colors.green),
        const SizedBox(width: 10),
        ButtonWidget(
            text: 'Cerrar',
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.grey[600]),
      ],
    );
  }

  void callPhone({required String phone}) async {
    final url = Uri(scheme: 'tel', path: '+51$phone');

    if (await canLaunchUrl(url)) {
      launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void showCamino(bool isCliente, JsonDatosDelivery delivery) async {
    final latitude = isCliente
        ? delivery.pHeader?.arrDatosDelivery?.direccionEnvioSelected?.latitude
        : delivery.pHeader?.arrDatosDelivery?.establecimiento?.latitude ?? 0;
    final longitude = isCliente
        ? delivery.pHeader?.arrDatosDelivery?.direccionEnvioSelected?.longitude
        : delivery.pHeader?.arrDatosDelivery?.establecimiento?.longitude ?? 0;

    final isShowCaminoComercio = latitude != 0 && longitude != 0;

    if (!isShowCaminoComercio) return;

    final url =
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving';

    final websiteUrl = Uri.parse(url);

    if (await canLaunchUrl(websiteUrl)) {
      await launchUrl(websiteUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir el enlace: $url';
    }
  }
}
