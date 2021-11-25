

class ProductData{


final int id ;
final String title;
final String description;
final String category;
final String image;
final String price;
final String rate;
final int count;
ProductData({required this.title,required this.id, required this.image,required this.category, required this.description,required this.count,required this.price,required this.rate});

factory ProductData.fromJson(dynamic json){
  return ProductData(
      title: json["title"] as String,
    id:json["id"] as int,
    image:json["image"] as String,
    category:json["category"] as String,
    price: json["price"].toString(),
    description:json["description"] as String,
    rate:json["rating"]["rate"].toString(),
      count:json['rating']['count'] as int,

    );
}

static List<ProductData> productsFromSnapshot(List snapshot){
  return snapshot.map(
      (data){
        return ProductData.fromJson(data);
      }
  ).toList();
}

@override
String toString () {
  return  'ProductData { title: $title,id: $id, image:$image,category:$category,price:$price,description:$description,rate:$rate,count: $count}';
}
}



