public class RemindOpptyOwners implements Schedulable {
  public void execute(SchedulableContext ctx) {
    List<Opportunity> opptys = [
      SELECT Id, Name, OwnerId, CloseDate
      FROM Opportunity
      WHERE IsClosed = FALSE AND CloseDate < TODAY
    ];

    TaskUtils.remindOwners(opptys);
  }
}
