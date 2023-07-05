class Product {
  String id;
  String title;
  String description;
  int price;
  List<dynamic> biggestBid;
  String? weight;
  String imgUrl;
  String category;
  String endDate;
  String paymentMethod;
  String auctionState;

  //ممكن نحط انيبلد علشان لما المزاد يخلص يبقي فولص
  // افيلبل دي علشان لما الادمن يوافق ع البرودكت تبقي ترو
  List<dynamic> winnerID;
  String sellerId;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.biggestBid,
    required this.imgUrl,
    required this.category,
    required this.endDate,
    // this.confirmed=false,
    // this.available = true,
    required this.auctionState,
    this.weight,
    this.paymentMethod = '',
    this.sellerId = '',
    required this.winnerID ,
  });

  Product.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          biggestBid: json['biggestBid'],
          imgUrl: json['imgUrl'],
          category: json['category'],
          endDate: json['endDate'],
          //confirmed: json['confirmed'],
          // available: json['available'],
          weight: json['weight'],
          auctionState: json['auctionState'],
          sellerId: json['sellerId'],
          winnerID: json['winnerID'],
          title: json['title'],
          description: json['description'],
          price: json['price'],
          paymentMethod: json['paymentMethod'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'biggestBid': biggestBid,
      'imgUrl': imgUrl,
      'category': category,
      'endDate': endDate,
      // 'confirmed': confirmed,
      // 'available': available,
      'auctionState': auctionState,
      'weight': weight,
      'sellerId': sellerId,
      'winnerID': winnerID,
      'title': title,
      'description': description,
      'price': price,
      'paymentMethod': paymentMethod,
    };
  }
}
