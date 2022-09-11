public class CaseTriggerHandler extends TriggerHandler {

    private List<Case> newCases;

    public CaseTriggerHandler() {
        this.newCases = Trigger.new;
    }

     public override void beforeInsert(){
        CaseTriggerHelper.checkBeforeAddNewCase(newCases);
     }

     public override void beforeUpdate() {
        CaseTriggerHelper.registerAttendees(newCases);
     }

}