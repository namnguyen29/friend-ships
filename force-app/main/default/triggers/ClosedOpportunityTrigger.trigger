trigger ClosedOpportunityTrigger on Opportunity(after insert, after update) {
  List<Task> tasks = new List<Task>();
  List<Opportunity> opps = Trigger.new;

  for (Opportunity opp : Trigger.new) {
    if (opp.StageName == 'Closed Won') {
      Task currentTask = new Task(WhatId = opp.Id, Subject = 'Follow Up Test Task');
      tasks.add(currentTask);
    }
  }

  if (tasks.size() > 0) {
    insert tasks;
  }
}

/**
 * add task to opp if opp statge is closed won
 */