import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gobid_admin/model/product.dart';

class ProductCard extends StatelessWidget {
  Product product;
  String sellerName;
  String? winnerName;
  Function() onPressed;
  String btnTxt;
  String ? cancelBtnTxt;
  Function()? cancelBtnPress;

  // Function()? onPressed;
  //  ProductCard({required this.product, this.onPressed});

  ProductCard({
    required this.product,
    required this.sellerName,
    required this.onPressed,
    required this.btnTxt,
    this.winnerName,
    this.cancelBtnPress,
    this.cancelBtnTxt
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => Navigator.of(context, rootNavigator: true)
      //     .pushNamed(ProductDetails.routeName, arguments: product.id),
      child: SizedBox(
        width: double.infinity,
        height: 220,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 210,
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          const SizedBox(width: 135),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  product.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Initial Price : ${product.price.toString()} LE',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: Colors.grey),
                                ),
                                if (winnerName == null)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('No one raise the bid!',
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 14)),
                                      SizedBox(height: 10),
                                      Text(
                                        'Seller: $sellerName',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  )
                                else
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Biggest Price : ${product.biggestBid.last.toString()} LE',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.grey),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Seller: $sellerName',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Row(
                                        children: [
                                          Text('winner: ',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic)),
                                          Expanded(
                                            child: Text(winnerName!,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontStyle:
                                                        FontStyle.italic)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    cancelBtnPress == null
                                        ? const SizedBox()
                                        : ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.redAccent,
                                                foregroundColor: Colors.white),
                                            onPressed: cancelBtnPress,
                                            child: Text(cancelBtnTxt!),
                                          ),
                                    SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: onPressed,
                                      child: Text(btnTxt),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 20,
              left: 15,
              child: SizedBox(
                width: 120,
                // color: Colors.red,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage(
                    placeholder:
                        const AssetImage('assets/images/Loading_icon.gif'),
                    image: NetworkImage(product.imgUrl),
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
