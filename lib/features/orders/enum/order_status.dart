enum OrderStatus {
  Completed("completed"),
  Processing("processing"),
  Cancelled("cancelled");

  final String value;
  const OrderStatus(this.value);

  factory OrderStatus.fromString(String status) {
    if (status == "completed") {
      return OrderStatus.Completed;
    } else if (status == "cancelled") {
      return OrderStatus.Cancelled;
    } else {
      return OrderStatus.Processing;
    }
  }
}
