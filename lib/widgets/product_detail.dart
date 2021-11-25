import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductDetails extends StatefulWidget {
  final String image;
  final String title;
  final String price;
  final String Description;
  final String Rating;
  final int count;

  ProductDetails(
      {required this.image,
      required this.title,
      required this.price,
      required this.Description,
      required this.Rating,
      required this.count});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          child: AppBar(
            elevation: 0.0,
            iconTheme: IconThemeData(color: Color(0xFFF47D15)),
            backgroundColor: Colors.transparent,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .4,
          child:   InteractiveViewer(child: Image.network(widget.image,width: 220,height: 320,),),
        ),

        Container(
          height: MediaQuery.of(context).size.height * .4,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 20),
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "${widget.Rating}/5",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                Text(
                  widget.Description,
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 200,
            decoration: BoxDecoration(
                color: Color(0xFFFC8A42),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "\$${widget.price}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .045,
                    width: MediaQuery.of(context).size.width * .33,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Text(
                        "Add to Cart",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
