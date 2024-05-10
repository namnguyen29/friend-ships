@IsTest
public with sharing class AnimalLocatorTest {
  @IsTest
  static void testAnimalLocator() {
    Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
    String response = AnimalLocator.getAnimalNameById(1);
    Assert.areEqual('chicken', response);
  }
}