class UserService {
  String category, serviceDesc, chargeType, docID;
  double price;
  int estTime;
  bool deleted;

  UserService(this.category, this.serviceDesc, this.price, this.estTime,
      this.chargeType, this.docID, this.deleted);
}
