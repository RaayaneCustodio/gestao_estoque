class Sale {
  int id;
  int customerId;
  int productId;
  int quantidade;
  double precoUnitario;
  DateTime data;

  Sale({
    required this.id,
    required this.customerId,
    required this.productId,
    required this.quantidade,
    required this.precoUnitario,
    required this.data,
  });
}
