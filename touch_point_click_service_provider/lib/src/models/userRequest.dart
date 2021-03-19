class UserRequest {
  String _id, _clientName, _clientAddress, _date, _time, _requestID;

  //***********Getter methods***********/
  String getID() => this._id;
  String getClientName() => this._clientName;
  String getClientAddress() => this._clientAddress;
  String getDate() => this._date;
  String getTime() => this._time;
  String getRequestID() => this._requestID;

  //***********Setter methods***********//
  void setID(String id) => this._id = id;
  void setClientName(String clientName) => this._clientName = clientName;
  void setClientAddress(String clientAddress) =>
      this._clientAddress = clientAddress;
  void setDate(String date) => this._date = date;
  void setTime(String time) => this._time = time;
  void setRequestID(String requestID) => this._requestID = requestID;
}
