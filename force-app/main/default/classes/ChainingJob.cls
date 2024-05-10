public class ChainingJob implements Queueable {
  public void execute(QueueableContext context) {
    // Awesome processing logic here
    // Chain this job to next job by submitting the next job
    System.enqueueJob(new SecondJob());
  }
}
