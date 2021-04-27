class UserSchedule {
  String startDate, endDate, startTime, endTime, docID;

  bool autoOnline, autoAccept;

  UserSchedule(
      {this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.autoOnline,
      this.autoAccept,
      this.docID});
}
