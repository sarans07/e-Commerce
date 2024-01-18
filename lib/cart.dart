class Cart {
  Map<int, int>? items = {};

  void addItem(int productId, int quantity) {
    if (items == null) {
      items = {productId: quantity};
    } else if (items!.containsKey(productId)) {
      items![productId] = (items![productId] ?? 0) + quantity;
    } else {
      items![productId] = quantity;
    }
  }

  int getTotalItems() {
    return items?.values.reduce((sum, value) => sum + value) ?? 0;
  }

  void updateQuantity(int productId, int quantity) {
    if (items != null && items!.containsKey(productId)) {
      items![productId] = quantity;
    }
  }
}
