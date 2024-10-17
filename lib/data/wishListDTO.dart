class WishListDTO {
  int? idx;
  String? productId;
  String? productName;
  String? price;
  String? imgId;

  WishListDTO({
    this.idx,
    this.productId,
    this.productName,
    this.price,
    this.imgId,
  });

  factory WishListDTO.fromJson(Map<String, dynamic> json) {
    return WishListDTO(
      idx: json['IDX'],
      productId: json['PRODUCT_ID'],
      productName: json['PRODUCTNAME'],
      price: json['PRICE'],
      imgId: json['IMGID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idx': idx,
      'product_id': productId,
      'productName': productName,
      'price': price,
      'imgId': imgId,
    };
  }
}
