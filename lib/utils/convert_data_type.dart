 convertType(dynamic value) {
  value == null
      ? 'null'
      : value.runtimeType == String
          ? value.toString()
          : value.runtimeType == int
              ? int.parse(value)
              : value.runtimeType == double
                  ? double.parse(value)
                  : '';
}

// products[i].offerPrice == null
// ? "null"
// : products[i].offerPrice.runtimeType == String
// ? products[i].offerPrice.toString()
// : products[i].offerPrice.runtimeType == Int
// ? int.parse(products[i].offerPrice)
// : products[i].offerPrice.runtimeType == Double
// ? double.parse(products[i].offerPrice)
// : ""
