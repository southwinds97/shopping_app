class ProductDTO {
  String? productId;
  String? subCate;
  String? productName;
  String? productContent;
  int? stock;
  String? price;
  String? imgId;
  DateTime? regidate;
  String? optionId;
  String? memberId;
  String? optionCate;
  int? idx;
  int? sellCount;
  String? optionIdList;
  List<String>? optionList;
  String? cdName;
  String? cartDtlId;
  int? quantity;
  String? optionYn;

  ProductDTO({
    this.productId,
    this.subCate,
    this.productName,
    this.productContent,
    this.stock,
    this.price,
    this.imgId,
    this.regidate,
    this.optionId,
    this.memberId,
    this.optionCate,
    this.idx,
    this.sellCount,
    this.optionIdList,
    this.optionList,
    this.cdName,
    this.cartDtlId,
    this.quantity,
    this.optionYn,
  });

  factory ProductDTO.fromJson(Map<String, dynamic> json) {
    return ProductDTO(
      productId: json['product_id'],
      subCate: json['sub_cate'],
      productName: json['product_name'],
      productContent: json['product_content'],
      stock: json['stock'],
      price: json['price'],
      imgId: json['img_id'],
      regidate: DateTime.tryParse(json['regidate'] ?? ''),
      optionId: json['option_id'],
      memberId: json['member_id'],
      optionCate: json['option_cate'],
      idx: json['idx'],
      sellCount: json['sell_count'],
      optionIdList: json['option_id_list'],
      optionList: json['option_list'] != null
          ? List<String>.from(json['option_list'])
          : null,
      cdName: json['cd_name'],
      cartDtlId: json['cart_dtl_id'],
      quantity: json['quantity'],
      optionYn: json['option_yn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'sub_cate': subCate,
      'product_name': productName,
      'product_content': productContent,
      'stock': stock,
      'price': price,
      'img_id': imgId,
      'regidate': regidate?.toIso8601String(),
      'option_id': optionId,
      'member_id': memberId,
      'option_cate': optionCate,
      'idx': idx,
      'sell_count': sellCount,
      'option_id_list': optionIdList,
      'option_list': optionList,
      'cd_name': cdName,
      'cart_dtl_id': cartDtlId,
      'quantity': quantity,
      'option_yn': optionYn,
    };
  }
}