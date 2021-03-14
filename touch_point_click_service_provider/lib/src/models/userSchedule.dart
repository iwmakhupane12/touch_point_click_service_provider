class UserSchedule {
  String _id, _startDate, _endDate, _startTime, _endTime;

  bool _autoOnline, _autoAccept;

  //***********Getter methods***********/
  String getID() => this._id;

  bool getAutoOnline() => this._autoOnline;

  bool getAutoAccept() => this._autoAccept;

  String getStartDate() => this._startDate;

  String getEndDate() => this._endDate;

  String getStartTime() => this._startTime;

  String getEndTime() => this._endTime;

  //***********Setter methods***********//
  void setID(String id) => this._id = id;

  void setAutoOnline(bool autoOnline) => this._autoOnline = autoOnline;

  void setAutoAccept(bool autoAccept) => this._autoAccept = autoAccept;

  void setStartDate(String startDate) => this._startDate = startDate;

  void setEndDate(String endDate) => this._endDate = endDate;

  void setStartTime(String startTime) => this._startTime = startTime;

  void setEndTime(String endTime) => this._endTime = endTime;
}
