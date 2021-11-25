import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:products/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'CustomShapeClipper.dart';
import 'package:products/modal/productAPI.dart';
import 'package:products/modal/products.dart';
import 'package:products/widgets/product_detail.dart';
import 'products_page.dart';

late List<ProductData> _filterdproducts;

class TopPart extends StatefulWidget {
  TextEditingController controller = TextEditingController();

  @override
  _TopPartState createState() => _TopPartState();
}

class _TopPartState extends State<TopPart> {
  late List<ProductData> _products;
  TextEditingController controller = new TextEditingController();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(' Log Out'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to logout ${user.displayName}?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'No',
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _getSeachProducts() async {
    _products = _filterdproducts = await ProductApi.getProductApi();
  }

  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    _getSeachProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [firstColor, secondColor]),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.cen,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    showSearch(
                                        context: context,
                                        delegate: DataSearch());
                                  },
                                ),
                                FlatButton(
                                  minWidth: 0.0,
                                    onPressed: () {
                                      showSearch(
                                          context: context,
                                          delegate: DataSearch());
                                    },
                                    child: Text(
                                      "Search",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      PopupMenuButton(
                        onSelected: (index) {
                          if (index == 0) {
                            _showMyDialog();
                          }
                        },
                        itemBuilder: (context) => <PopupMenuItem<int>>[
                          PopupMenuItem(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(user.photoURL!),
                                ),
                                Text(
                                  user.displayName!,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  user.email!,
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.logout),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text(
                                  "log Out",
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                            value: 0,
                          )
                        ],
                        child: Row(
                          children: [
                            Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 29.0,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final recentHistory = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {


    return Center(
      child: Container(
        child:Text("please Select from the Drop Down Items"),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = query.isEmpty
        ? _filterdproducts
        : _filterdproducts
            .where((element) =>
                element.title.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return suggestion.isEmpty
        ? Center(
            child: Text(
              "Item not Found '$query'",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          )
        : ListView.builder(
            itemCount:query.isEmpty? suggestion.length-17 : suggestion.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetails(
                            image: suggestion[index].image,
                            title: suggestion[index].title,
                            price: suggestion[index].price,
                            Description: suggestion[index].description,
                            Rating: suggestion[index].rate,
                            count: suggestion[index].count)),
                  );
                },

               title: Wrap(
                  children: [

                    RichText(
                      text: TextSpan(

                          text: suggestion[index]
                              .title
                              .substring(0, query.length),
                          style: TextStyle(textBaseline: TextBaseline.ideographic,
                              color: Colors.black, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: suggestion[index]
                                    .title
                                    .substring(query.length),
                                style: TextStyle(color: Colors.grey))
                          ]),
                    )
                  ],
                ),

                leading: Image.network(suggestion[index].image ,width: 30,),
              );
            });

  }
}
