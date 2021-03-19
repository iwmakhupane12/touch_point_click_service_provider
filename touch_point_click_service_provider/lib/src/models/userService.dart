class UserService {
  String _id, _category, _serviceDesc, _price, _estTime;

  //***********Getter methods***********//
  String getID() => this._id;
  String getCategory() => this._category;
  String getServiceDesc() => this._serviceDesc;
  String getPrice() => this._price;
  String getEstTime() => this._estTime;

  //***********Setter methods***********//
  void setID(String id) => this._id = id;
  void setCategory(String category) => this._category = category;
  void setServiceDesc(String serviceDesc) => this._serviceDesc = serviceDesc;
  void setPrice(String price) => this._price = price;
  void setEstTime(String estTime) => this._estTime = estTime;
}
