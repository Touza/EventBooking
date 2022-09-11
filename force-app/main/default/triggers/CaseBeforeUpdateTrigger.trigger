trigger CaseBeforeUpdateTrigger on Case (before update, after update) {
    new CaseTriggerHandler().run();
}