import 'package:firmer_city/config/router/router.dart';
import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/core/widget/custom_drop_down.dart';
import 'package:firmer_city/core/widget/custom_input.dart';
import 'package:firmer_city/features/dashboard/provider/new_product_provider.dart';
import 'package:firmer_city/features/dashboard/provider/products_provider.dart';
import 'package:firmer_city/utils/colors.dart';
import 'package:firmer_city/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_dialog.dart';
import '../../provider/edit_product_provider.dart';

class EditProduct extends ConsumerStatefulWidget {
  const EditProduct({super.key, required this.id});
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProductState();
}

class _EditProductState extends ConsumerState<EditProduct> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var products = ref.watch(dashboardProductProvider);
    var selectedProduct = products.products
        .where((element) => element.id == widget.id)
        .firstOrNull;
    if (selectedProduct != null) {
      //wait for widget to build
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(editProductProvider.notifier).setProduct(selectedProduct);
      });
    }
    var notifier = ref.watch(editProductProvider.notifier);
    var provider = ref.watch(editProductProvider);
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SizedBox(
          width: styles.isMobile
              ? double.infinity
              : styles.isTablet
                  ? styles.width * 0.7
                  : styles.width * 0.6,
          child: Column(
            children: [
              Row(
                children: [
                  //close
                  IconButton(
                      onPressed: () {
                        MyRouter(context: context, ref: ref)
                            .navigateToRoute(RouterInfo.productRoute);
                      },
                      icon: const Icon(Icons.close)),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Edit Products'.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: styles.title(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            desktop: 30,
                            mobile: 25,
                            tablet: 25),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                thickness: 3,
                color: primaryColor,
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Wrap(
                  spacing: 15,
                  runSpacing: 30,
                  children: [
                    SizedBox(
                        width: styles.isMobile
                            ? double.infinity
                            : styles.isTablet
                                ? styles.width * 0.35
                                : styles.width * 0.3,
                        child: CustomTextFields(
                          hintText: 'Product Name',
                          controller:
                              TextEditingController(text: provider.productName),
                          label: 'Product Name',
                          validator: (name) {
                            if (name!.isEmpty) {
                              return 'Product name is required';
                            }
                            return null;
                          },
                          onSaved: (name) {
                            notifier.setProductName(name!);
                          },
                        )),
                    SizedBox(
                      width: styles.isMobile
                          ? double.infinity
                          : styles.isTablet
                              ? styles.width * 0.35
                              : styles.width * 0.3,
                      child: CustomDropDown(
                          items: [
                            'Animal Products',
                            'Crops',
                            'Fruits',
                            'Vegetables'
                          ]
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          value: provider.productCategory,
                          hintText: 'Product Category',
                          validator: (cat) {
                            if (cat!.isEmpty) {
                              return 'Product category is required';
                            }
                            return null;
                          },
                          label: 'Product Category',
                          onChanged: (value) {
                            notifier.setProductCategory(value);
                          }),
                    ),
                    SizedBox(
                        width: styles.isMobile
                            ? double.infinity
                            : styles.isTablet
                                ? styles.width * 0.35
                                : styles.width * 0.3,
                        child: CustomTextFields(
                          hintText: 'Product description',
                          label: 'Product description',
                          maxLines: 3,
                          controller: TextEditingController(
                              text: provider.productDescription),
                          validator: (des) {
                            if (des!.isEmpty) {
                              return 'Product description is required';
                            }
                            return null;
                          },
                          onSaved: (des) {
                            notifier.setProductDescription(des!);
                          },
                        )),
                    SizedBox(
                        width: styles.isMobile
                            ? double.infinity
                            : styles.isTablet
                                ? styles.width * 0.35
                                : styles.width * 0.3,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextFields(
                                hintText: 'Product Price',
                                label: 'Product Price',
                                controller: TextEditingController(
                                    text: provider.productPrice),
                                keyboardType: TextInputType.number,
                                isDigitOnly: true,
                                validator: (price) {
                                  if (price!.isEmpty) {
                                    return 'Product price is required';
                                  }
                                  return null;
                                },
                                onSaved: (price) {
                                  notifier.setProductPrice(price!);
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomTextFields(
                                hintText: 'Product Stock',
                                label: 'Product Stock',
                                controller: TextEditingController(
                                    text: provider.productStock.toString()),
                                keyboardType: TextInputType.number,
                                isDigitOnly: true,
                                validator: (quantity) {
                                  if (quantity!.isEmpty) {
                                    return 'Product stock is required';
                                  }
                                  return null;
                                },
                                onSaved: (quantity) {
                                  notifier.setStock(quantity!);
                                },
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                        width: styles.isMobile
                            ? double.infinity
                            : styles.isTablet
                                ? styles.width * 0.35
                                : styles.width * 0.3,
                        child: CustomDropDown(
                          hintText: 'Product measurement',
                          value: provider.productMeasurement,
                          validator: (meas) {
                            if (meas!.isEmpty) {
                              return 'Product measurement is required';
                            }
                            return null;
                          },
                          items: [
                            'Kg',
                            'Gram',
                            'Litre',
                            'Unit',
                            'Bag',
                            'Bunch',
                            'Box',
                            'Bundle',
                            'Can',
                            'Carton',
                            'Dozen',
                            'Each',
                            'Gallon',
                            'Jar',
                            'Packet',
                            'Piece',
                            'Roll',
                            'Set',
                            'Ton',
                            'Tray',
                            'Tube',
                            'Yard'
                          ]
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          label: 'Product Measurement',
                          onChanged: (value) {
                            notifier.setMeasurement(value);
                          },
                        )),
                    SizedBox(
                        width: styles.isMobile
                            ? double.infinity
                            : styles.isTablet
                                ? styles.width * 0.35
                                : styles.width * 0.3,
                        child: Column(
                          children: [
                            if (ref.watch(productImagesProvider).isNotEmpty)
                              Row(
                                children: ref
                                    .watch(productImagesProvider)
                                    .map((image) => Container(
                                          height: 80,
                                          width: 80,
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: MemoryImage(image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: TextButton(
                                              onPressed: () {
                                                notifier.removeImage(image,
                                                    ref: ref);
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              )),
                                        ))
                                    .toList(),
                              )
                            else
                              Row(
                                children: [
                                  for (var url in provider.productImages)
                                    Container(
                                      height: 80,
                                      width: 80,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(url),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            notifier.removeImageUrl(url);
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )),
                                    )
                                ],
                              ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                  onPressed: () {
                                    notifier.pickImage(ref: ref);
                                  },
                                  child: const Text('Add Product Image')),
                            )
                          ],
                        )),
                    SizedBox(
                        width: styles.isMobile
                            ? double.infinity
                            : styles.isTablet
                                ? styles.width * .7
                                : styles.width * .6,
                        child: CustomButton(
                            radius: 5,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (ref.watch(productImagesProvider).isEmpty &&
                                    provider != null &&
                                    provider.productImages.isEmpty) {
                                  CustomDialog.showToast(
                                      message: 'Please add product image');
                                  return;
                                }
                                _formKey.currentState!.save();
                                notifier.updateProduct(
                                    context: context, ref: ref, form: _formKey);
                              }
                            },
                            text: 'Update Product'))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
