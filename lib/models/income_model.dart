
class IncomeModel{
  
  final String incomeId, incomeName, addedDate;
  final int addedMonth, addedYear;
  final int incomeAmount;

  IncomeModel({
    required this.incomeId,
    required this.incomeName,
    required this.incomeAmount,
    required this.addedDate,
    required this.addedMonth,
    required this.addedYear,
  });
}