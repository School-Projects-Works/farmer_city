import 'package:data_table_2/data_table_2.dart';
import 'package:firmer_city/config/router/router.dart';
import 'package:firmer_city/core/widget/custom_button.dart';
import 'package:firmer_city/core/widget/custom_dialog.dart';
import 'package:firmer_city/core/widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../config/router/router_info.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import '../../../auth/provider/login_provider.dart';
import '../../provider/products_provider.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var user = ref.watch(userProvider);
    var products = ref.watch(dashboardProductProvider);
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
                Text('Products',
                    style:
                        styles.title(desktop: 27, fontWeight: FontWeight.bold)),
                const Spacer(),
                SizedBox(
                  width: styles.width * 0.3,
                  child: CustomTextFields(
                    hintText: 'Search products',
                    onChanged: (value) {
                      ref
                          .read(dashboardProductProvider.notifier)
                          .filterProducts(value);
                    },
                  ),
                ),
                const SizedBox(width: 20),
                CustomButton(
                  text: 'Add Product',
                  onPressed: () {
                    MyRouter(context: context, ref: ref)
                        .navigateToRoute(RouterInfo.newProductRoute);
                  },
                  radius: 10,
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: products.filteredProducts.isEmpty
                  ? const Center(child: Text('No products found'))
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
                                'IMAGE',
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
                                  'PRODUCT NAME',
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
                                  'CATEGORY',
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
                                'MEASUREMENT',
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
                                  'PRICE',
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
                                'STOCK',
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
                          rows: products.filteredProducts.isNotEmpty
                              ? products.filteredProducts.map((product) {
                                  return DataRow(cells: [
                                    DataCell(Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.network(
                                        product.productImages.first,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                    DataCell(Text(product.productName)),
                                    DataCell(Text(product.productCategory)),
                                    DataCell(
                                        Text(product.productMeasurement ?? '')),
                                    DataCell(Text(
                                        'GHS${double.parse(product.productPrice).toStringAsFixed(2)}')),
                                    DataCell(Text('${product.productStock}')),
                                    DataCell(Text(DateFormat('EEE,MMM dd, yyyy')
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                product.createdAt)))),
                                    DataCell(PopupMenuButton(
                                      itemBuilder: (context) {
                                        return [
                                          //delete, edit and view
                                          // PopupMenuItem(
                                          //   child: ListTile(
                                          //     leading: const Icon(
                                          //         Icons.remove_red_eye),
                                          //     title: const Padding(
                                          //       padding:
                                          //           EdgeInsets.only(right: 20),
                                          //       child: Text('View'),
                                          //     ),
                                          //     onTap: () {
                                          //       //view product
                                          //     },
                                          //   ),
                                          // ),
                                          PopupMenuItem(
                                            child: ListTile(
                                              leading: const Icon(Icons.edit),
                                              title: const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 20),
                                                child: Text('Edit'),
                                              ),
                                              onTap: () {
                                                MyRouter(
                                                        context: context,
                                                        ref: ref)
                                                    .navigateToNamed(
                                                  item: RouterInfo
                                                      .editProductRoute,
                                                  pathParms: {'id': product.id},
                                                );
                                              },
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: ListTile(
                                              leading: const Icon(Icons.delete),
                                              title: const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 20),
                                                child: Text('Delete'),
                                              ),
                                              onTap: () {
                                                CustomDialog.showInfo(
                                                  message:
                                                      'Are you sure you want to delete this product?',
                                                  buttonText: 'Delete',
                                                  onPressed: () {
                                                    ref
                                                        .read(
                                                            dashboardProductProvider
                                                                .notifier)
                                                        .deleteProduct(
                                                            product.id);
                                                    Navigator.of(context).pop();
                                                  },
                                                );
                                              },
                                            ),
                                          ),
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
