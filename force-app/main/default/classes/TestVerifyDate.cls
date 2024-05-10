@isTest
public with sharing class TestVerifyDate {
  @isTest
  public static void testDateWithin30Days() {
    Date date1 = Date.today();
    Date date2 = date1.addDays(15);
    Date checkDate = VerifyDate.CheckDates(date1, date2);
    System.assertEquals(date2, checkDate, 'date2 isn\'t within 30 days of date1');
  }

  @isTest
  public static void testDateNotWithin30Days() {
    Date date1 = Date.today();
    Date date2 = date1.addDays(100);
    Date checkDate = VerifyDate.CheckDates(date1, date2);
    Date lastDate1 = Date.newInstance(
      date1.year(),
      date1.month(),
      Date.daysInMonth(date1.year(), date1.month())
    );
    System.assertEquals(lastDate1, checkDate, 'date2 is away 30 day of date1');
  }

  @isTest
  public static void testDate2BeforeDate1() {
    Date date2 = Date.newInstance(2024, 1, 3);
    Date date1 = Date.newInstance(2024, 10, 3);
    Date checkDate = VerifyDate.CheckDates(date1, date2);
    Date lastDate1 = Date.newInstance(
      date1.year(),
      date1.month(),
      Date.daysInMonth(date1.year(), date1.month())
    );
    System.assertEquals(lastDate1, checkDate, 'date2 < date1 or dat2 is within 30 day of date1');
  }
}