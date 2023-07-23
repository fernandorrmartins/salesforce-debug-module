public without sharing class DebugModuleClassesTrackerController {
    @AuraEnabled
    public static string getApexClassesList(){
        List<SObject> apexClassList;
        try {
            List<List<SObject>> soslResult = [FIND '%Debug.getInstance%' IN ALL FIELDS RETURNING ApexClass(Id, Name, Status)];
            apexClassList = soslResult != null && soslResult.size() > 0 ? soslResult.get(0) : new List<SObject>();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return apexClassList;
    }
}