import 'package:data_table_2/data_table_2.dart';
import 'package:firmer_city/core/widget/custom_dialog.dart';
import 'package:firmer_city/core/widget/custom_input.dart';
import 'package:firmer_city/features/auth/provider/login_provider.dart';
import 'package:firmer_city/features/cart/data/cart_model.dart';
import 'package:firmer_city/features/dashboard/provider/orders_provider.dart';
import 'package:firmer_city/features/market/data/product_model.dart';
import 'package:firmer_city/utils/colors.dart';
import 'package:firmer_city/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var user = ref.watch(userProvider);
    var orders = ref.watch(orderProvider);
    return Container(
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Row(
              children: [
                Text('Orders',
                    style:
                        styles.title(desktop: 27, fontWeight: FontWeight.bold)),
                const Spacer(),
                SizedBox(
                  width: styles.width * 0.3,
                  child: CustomTextFields(
                    hintText: 'Search Orders',
                    onChanged: (value) {
                      ref.read(orderProvider.notifier).filterOrders(value);
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: orders.filteredOrders.isEmpty
                  ? const Center(child: Text('No New Orders'))
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: DataTable2(
                          columnSpacing: 12,
                          horizontalMargin: 12,
                          headingRowColor:
                              WidgetStateProperty.all(primaryColor),
                          minWidth: 600,
                          columns: [
                            DataColumn2(
                              label: Text(
                                'ORDER ID',
                                style: styles.body(
                                    color: Colors.white,
                                    desktop: 14,
                                    mobile: 13,
                                    tablet: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                                label: Text(
                                  'CUSTOMER NAME',
                                  style: styles.body(
                                      color: Colors.white,
                                      desktop: 14,
                                      mobile: 13,
                                      tablet: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                size: ColumnSize.L),
                            DataColumn2(
                                label: Text(
                                  'CUSTOMER ADDRESS',
                                  style: styles.body(
                                      color: Colors.white,
                                      desktop: 14,
                                      mobile: 13,
                                      tablet: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                size: ColumnSize.L),
                            DataColumn2(
                                label: Text(
                                  'CUSTOMER PHONE',
                                  style: styles.body(
                                      color: Colors.white,
                                      desktop: 14,
                                      mobile: 13,
                                      tablet: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                size: ColumnSize.L),
                            DataColumn(
                              label: Text(
                                'PRODUCTS',
                                style: styles.body(
                                    color: Colors.white,
                                    desktop: 14,
                                    mobile: 13,
                                    tablet: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'TOTAL PRICE',
                                style: styles.body(
                                    color: Colors.white,
                                    desktop: 14,
                                    mobile: 13,
                                    tablet: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn2(
                                label: Text(
                                  'STATUS',
                                  style: styles.body(
                                      color: Colors.white,
                                      desktop: 14,
                                      mobile: 13,
                                      tablet: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                numeric: false,
                                size: ColumnSize.S),
                            DataColumn(
                              label: Text(
                                'CREATED AT',
                                style: styles.body(
                                    color: Colors.white,
                                    desktop: 14,
                                    mobile: 13,
                                    tablet: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              numeric: false,
                            ),
                            DataColumn(
                              label: Text(
                                'ACTION',
                                style: styles.body(
                                    color: Colors.white,
                                    desktop: 14,
                                    mobile: 13,
                                    tablet: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              numeric: false,
                            ),
                          ],
                          rows: orders.filteredOrders.isNotEmpty
                              ? orders.filteredOrders.map((order) {
                                  var cartItem = order.items
                                      .map((e) => CartItem.fromMap(e))
                                      .toList();
                                  var products = cartItem
                                      .map((e) =>
                                          ProductModel.fromMap(e.product))
                                      .toList();
                                  return DataRow(cells: [
                                    DataCell(Text(order.id.substring(5))),
                                    DataCell(Text(order.buyerName)),
                                    DataCell(Text(order.buyerAddress)),
                                    DataCell(Text(order.buyerPhone)),
                                    DataCell(Text(
                                      products
                                          .map((prod) => prod.productName)
                                          .join(','),
                                      maxLines: 1,
                                    )),
                                    DataCell(Text(
                                        'GHS${order.totalPrice.toStringAsFixed(2)}')),
                                    DataCell(Container(
                                        width: 122,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                            color: order.status.toLowerCase() ==
                                                    'cancelled'
                                                ? Colors.red.withOpacity(.8)
                                                : order.status.toLowerCase() ==
                                                        'pending'
                                                    ? Colors.grey
                                                        .withOpacity(.8)
                                                    : Colors.green
                                                        .withOpacity(.8),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          order.status,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ))),
                                    DataCell(Text(DateFormat('EEE,MMM dd, yyyy')
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                order.createdAt)))),
                                    DataCell(PopupMenuButton(
                                      onSelected: (value) {
                                        if (value == 'Delivered') {
                                          CustomDialog.showInfo(
                                              message:
                                                  'Are you sure you want to mark this order as delivered?',
                                              buttonText: 'Yes',
                                              onPressed: () {
                                                ref
                                                    .read(
                                                        orderProvider.notifier)
                                                    .updateOrder(order.copyWith(
                                                        status: 'delivered'));
                                              });
                                        } else {
                                          CustomDialog.showInfo(
                                              message:
                                                  'Are you sure you want to cancel this order?',
                                              buttonText: 'Yes',
                                              onPressed: () {
                                                ref
                                                    .read(
                                                        orderProvider.notifier)
                                                    .updateOrder(order.copyWith(
                                                        status: 'cancelled'));
                                              });
                                        }
                                      },
                                      itemBuilder: (context) {
                                        return [
                                          //show status
                                          if (order.status.toLowerCase() !=
                                                  'delivered' ||
                                              order.status.toLowerCase() !=
                                                      'cancelled' &&
                                                  order.buyerId != user.id)
                                            PopupMenuItem(
                                              value: 'Delivered',
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 40,
                                                    top: 5,
                                                    bottom: 5,
                                                    left: 10),
                                                child: Text(
                                                  'Delivered',
                                                  style: styles.body(),
                                                ),
                                              ),
                                            ),
                                          if (order.status.toLowerCase() !=
                                                  'cancelled' ||
                                              order.status.toLowerCase() !=
                                                  'delivered')
                                            PopupMenuItem(
                                                value: 'Cancelled',
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 40,
                                                          top: 5,
                                                          bottom: 5,
                                                          left: 10),
                                                  child: Text(
                                                    'Cancel',
                                                    style: styles.body(),
                                                  ),
                                                )),
                                        ];
                                      },
                                      child: const Icon(Icons.apps),
                                    ))
                                  ]);
                                }).toList()
                              : []),
                    ),
            ),
          ],
        ));
  }
}
