trigger CalloutTrigger on Account(before insert) {
  CalloutClass.makeCallout();
}