global with sharing class BatchTest implements Database.Batchable<sObject>, Schedulable {


    //used to schedule the batch class
    global void execute(SchedulableContext sc) {
        System.debug('batch test .schedule');

        //execute the batch
        BatchTest test = new BatchTest();
        ID batchprocessid = Database.executeBatch(test);
    }


    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug('batch test .start');

        String query = 'Select Id, Name from Account';

        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> accts) {
        System.debug('batch test . execute');

    }

    global void finish(Database.BatchableContext BC) {
        System.debug('batch test .finish');
    }

}