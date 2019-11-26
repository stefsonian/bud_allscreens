class Member {
  String userId;
  String roleName = '';
  bool isOwner,
      mayCreateExpense,
      mayEditOwnExpense,
      mayEditAnyExpense,
      mayUpdateTrip,
      mayDeleteTrip = false;

  Member() {}

  Member.withDemoData(String userId) {
    userId = userId;
    roleName = 'owner';
    isOwner = true;
    mayCreateExpense = true;
    mayEditOwnExpense = true;
    mayEditAnyExpense = true;
    mayUpdateTrip = true;
    mayDeleteTrip = true;
  }
}
