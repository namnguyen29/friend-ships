public class CalloutClass {
  @future(callout=true)
  public static void makeCallout() {
    HttpRequest request = new HttpRequest();
    String endpoint = 'https://jsonplaceholder.typicode.com/todos/1';
    request.setEndPoint(endpoint);
    request.setMethod('GET');
    HttpResponse response = new HTTP().send(request);
  }
}