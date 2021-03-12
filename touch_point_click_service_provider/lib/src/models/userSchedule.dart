class UserSchedule {
  String _id, _startDate, _endDate, _startTime, _endTime;
  UserSchedule(
      this._id, this._startDate, this._endDate, this._startTime, this._endTime);

  //***********Getter methods***********/
  String getID() => this._id;

  String getStartDate() => this._startDate;

  String getEndDate() => this._endDate;

  String getStartTime() => this._startTime;

  String getEndTime() => this._endTime;

  //***********Setter methods***********//
  void setID(String id) => this._id = id;

  void setStartDate(String startDate) => this._startDate = startDate;

  void setEndDate(String endDate) => this._endDate = endDate;

  void setStartTime(String startTime) => this._startTime = startTime;

  void setEndTime(String endTime) => this._endTime = endTime;
}
