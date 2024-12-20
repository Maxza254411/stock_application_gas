import 'package:flutter/material.dart';
import 'package:stock_application_gas/Models/order_dto.dart';
import 'package:stock_application_gas/Models/orderitemsdto1.dart';
import 'package:stock_application_gas/Models/panelproduct.dart';
import 'package:stock_application_gas/Product/widget/OpenDialogProduct.dart';
import 'package:stock_application_gas/widgets/viewPhoto.dart';

class ListItemProduct extends StatefulWidget {
  const ListItemProduct({super.key, required this.listItem, required this.onChange, required this.size, required this.orderDtoList});
  final List<PanelProduct> listItem;
  final ValueChanged<OrderItemsDto1> onChange;
  final Size size;
  final List<OrderDto> orderDtoList;

  @override
  State<ListItemProduct> createState() => _ListItemProductState();
}

class _ListItemProductState extends State<ListItemProduct> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.listItem.length,
        (index) {
          return GestureDetector(
            onTap: () async {
              final product = widget.listItem[index].product;
              if (product!.productAttributes!.isEmpty) {
                final OrderItemsDto1 orderItem = OrderItemsDto1(product.id, product.name ?? '', product.price ?? 0, product.price ?? 0, 1, [], null);

                widget.onChange(orderItem);
              } else {
                final item = await showModalBottomSheet<OrderItemsDto1>(
                  isDismissible: false,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => DraggableScrollableSheet(
                    expand: false,
                    builder: (context, scrollController) => OpenDialogProduct(
                      product: product,
                      controller: scrollController,
                    ),
                  ),
                );

                if (item != null) {
                  widget.onChange(item);
                }
              }
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.94,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                color: Colors.white70,
                elevation: 10,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.28,
                          maxHeight: MediaQuery.of(context).size.width * 0.28,
                        ),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ImagePhotoview(
                                        // image1: bgImg.length < 255 ? baseUrl + bgImg : bgImg,
                                        image1: '',
                                      )));
                            },
                            child: Image.asset('assets/images/bannerLogin.png', fit: BoxFit.fill)),
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                                child: Text(
                                  widget.listItem[index].product?.name ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                child: Text(
                                  '฿ ${widget.listItem[index].product?.price ?? ''}',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        widget.orderDtoList[0].orderItems?.isEmpty ?? true
                            ? SizedBox.shrink()
                            : Builder(
                                builder: (context) {
                                  int matchingCount = 0;
                                  // List<int> matchingCount = []; // ตัวแปรเก็บจำนวนที่ id ตรงกัน
                                  for (var item in widget.orderDtoList[0].orderItems!) {
                                    if (item.productId == widget.listItem[index].product?.id) {
                                      matchingCount++; // นับจำนวน id ที่ตรงกัน
                                    }
                                  }

                                  return matchingCount > 0
                                      ? Container(
                                          width: widget.size.width * 0.12,
                                          height: widget.size.height * 0.05,
                                          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(15)),
                                          child: Center(
                                              child: Text(
                                            '$matchingCount',
                                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                                          )),
                                        )
                                      : SizedBox.shrink();
                                },
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
