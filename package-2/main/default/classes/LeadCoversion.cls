public with sharing class LeadCoversion {

    public void doSomething(){

        //get business record type id
        Id businessRecordtypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Business').getRecordTypeId();
        system.debug('businessRecordtypeId ' + businessRecordtypeId);

        //create lead
        Lead myLead = new Lead(LastName = 'Fry3', Company='Fry And Sons3');
        insert myLead;

        //prep to convert convert lead
        Database.LeadConvert lc = new Database.LeadConvert();
        lc.setLeadId(myLead.id);
        //set create opportunity
        // lc.setDoNotCreateOpportunity = true;

        //get convert status label
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);

        //convert lead
        Database.LeadConvertResult lcr = Database.convertLead(lc);

        //check new record ids
        system.debug('lcr ' + lcr);
        system.debug('account ' + lcr.getAccountId());
        system.debug('contact ' + lcr.getContactId());
        system.debug('lead ' + lcr.getLeadId());
        system.debug('opportunity ' + lcr.getOpportunityId());

        //delete contact
        Id cId = lcr.getContactId();
        Contact newContact = [select id, name from Contact where id = :cId];
        delete newContact;

        //update account record type, didnt seem to work correctly
        Id aId = lcr.getAccountId();
        Account newAccount = [select id, name, recordTypeId, recordType.name from Account where id = :aId];
        newAccount.recordtypeId = businessRecordtypeId;
        update newAccount;



    }

}