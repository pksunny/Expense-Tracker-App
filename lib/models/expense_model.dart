
class ExpenseModel{
  
  final String expenseId, expenseName, addedDate;
  final int addedMonth, addedYear;
  final int expenseAmount;

  ExpenseModel({
    required this.expenseId,
    required this.expenseName,
    required this.expenseAmount,
    required this.addedDate,
    required this.addedMonth,
    required this.addedYear,
  });
}