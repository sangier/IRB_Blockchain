/*
 * Copyright IBM Corp. All Rights Reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

'use strict';

// Fabric smart contract classes
const { Contract, Context } = require('fabric-contract-api');

// PaperNet specifc classes
const AsPair = require('./aspair.js');
const AsList = require('./aslist.js');
const QueryUtils = require('./queries.js');

/**
 * A custom context provides easy access to list of all commercial papers
 */
class AsPairContext extends Context {

    constructor() {
        super();
        // All papers are held in a list of papers
        this.asList = new AsList(this);
    }

}

/**
 * Define commercial paper smart contract by extending Fabric Contract class
 *
 */
class AsPairContract extends Contract {

    constructor() {
        // Unique namespace when multiple contracts per chaincode file
        super('org.papernet.aspair');
    }

    /**
     * Define a custom context for commercial paper
    */
    createContext() {
        return new AsPairContext();
    }

    /**
     * Instantiate to perform any setup of the ledger that might be required.
     * @param {Context} ctx the transaction context
     */
    async instantiate(ctx) {
        // No implementation required with this example
        // It could be where data migration is performed, if necessary
        console.log('Instantiate the contract');
    }

    /**
     * Issue AsPair
     *
     * @param {Context} ctx the transaction context
     * @param {String} asn1 paper number for this issuer
     * @param {String} asn2 paper issue date
     * @param {String} relationship paper maturity date
     * @param {Integer} securityLevel face value of paper
     * @param {Integer} user face value of paper
    */


    async issue(ctx, asn1, asn2, relationship, securityLevel,user) {
        
        //Condition to evaluate if an AS_PAIR can be issued or not: 
        // IF KEY NOT UNDEFINED THEN CHECK IF STATE IS INVALID. 
        // NEED TO CHECK FOR BOTH DIRECTION (ASN1, ASN2) and (ASN2, ASN1)   
        let A0=0
        let A1=0
        let A2=0
        let aa1=""
        let AsPairKey = AsPair.makeKey([asn1, asn2]);
        try {
             let asPair= await ctx.asList.getASPair(AsPairKey)
             if(asPair.isInvalid()){A1=1}else{A1=0}   
            }catch(e){
                A1=1
            }

        
        AsPairKey = AsPair.makeKey([asn2, asn1]);
        
        try {
             let asPair= await ctx.asList.getASPair(AsPairKey)
             if(asPair.isInvalid()){A2=1}else{A2=0}   
            }catch(e){
                A2=1
            }
        
        try {
            aa1=asn1.substr(asn1.indexOf('.')+1)
            if(user==aa1){A0=1}else{A0=0} 
            }catch(e){
                A1=0
            }
           


        if (A0!=1) {
                throw new Error('\nUser no authorized to perform transaction   look a this:::: '+aa1+' and at this:::'+user);
            }   


        if ((A1 & A2)!=1) {
                    throw new Error('\nAS PAIR ALREADY EXISIT AND IS NOT INVALID: NOT ISSUABLE ');
                }   

      /*  if(stub.GetHistoryForKey(AsPairKey)!=0){

            throw new Error('\nAS PAIR ' + asn1 + asn2  + 'AlreadyExist ' + mspid);
        }*/

        /*async getHistoryForMarble(stub, args, thisClass) {

            if (args.length < 1) {
              throw new Error('Incorrect number of arguments. Expecting 1')
            }
            let marbleName = args[0];
            console.info('- start getHistoryForMarble: %s\n', marbleName);
        
            let resultsIterator = await stub.getHistoryForKey(marbleName);
            let method = thisClass['getAllResults'];
            let results = await method(resultsIterator, true);
        
            return Buffer.from(JSON.stringify(results));
          }*/


        // create an instance of the paper
        let asPair = AsPair.createInstance(asn1, asn2)//, relationship, parseInt(securityLevel));

        // Smart contract, rather than paper, moves paper into ISSUED state
        asPair.setIssued();
        asPair.setRelationship(relationship);


        // save the owner's MSP 
        let mspid = ctx.clientIdentity.getMSPID();

        // Newly issued paper is owned by the issuer to begin with (recorded for reporting purposes)
        asPair.setOwnerMSP(mspid);
        asPair.setIssuer(mspid);
        asPair.setRelationship(relationship);
        asPair.setAsn1(asn1);
        asPair.setAsn2(asn2);
        asPair.setSecurityLevel(parseInt(securityLevel));

        // Add the paper to the list of all similar commercial papers in the ledger world state
        await ctx.asList.addASPair(asPair);

        // Must return a serialized paper to caller of smart contract
        return asPair;
    }

    /**
     * Sign AS_PAIR 
     *
      * @param {Context} ctx the transaction context
      * @param {String} asn1 paper number for this issuer
      * @param {String} asn2 paper issue date
      * @param {String} relationship paper maturity date
      * @param {Integer} securityLevel face value of paper
      * @param {String} issuer commercial paper issuer
      * @param {Integer} user face value of paper
     */
    async sign(ctx, asn1 ,asn2,user) {
       
        // Retrieve the current paper using key fields provided
        let AsPairKey = AsPair.makeKey([asn1, asn2]);
        let asPair = await ctx.asList.getASPair(AsPairKey);

        // Validate current owner
        let mspid = ctx.clientIdentity.getMSPID();

        let A0=0
        let aa1=asn1.substr(asn1.indexOf('.')+1)
        let aa2=asn2.substr(asn2.indexOf('.')+1)
        
        if(user==aa1 || user ==aa2){A0=1}else{A0=0}

        console.log('THE WAY AN MSPID LOOK LIKE: '+ mspid);

        let ACL=""
        let currentOwner=asPair.getIssuer()

        if(currentOwner==asPair.getMSPID1()){
            ACL=asPair.getMSPID2()  
        }
        if(currentOwner==asPair.getMSPID2()){
            ACL=asPair.getMSPID1()  
        }
        
        if (A0!=1) {
            throw new Error('\nUser not authorized to perform transaction');
        }   

        if (mspid != ACL) {
            throw new Error('\nCURRENT OWNER: ' +currentOwner+' CANNOT MODIFY , ACL IS:'+ ACL+' AS PAIR ' + asn1 + asn2  + 'cannot be modified by ' + mspid);
        }

        // First buy moves state from ISSUED to TRADING (when running )
        if (asPair.isIssued()) {
            asPair.setVerified();
            asPair.setSecurityLevel(2);
        }
	 else {
            throw new Error('\nAS PAIR ' + asn1 + asn2  + ' is not in issued State. Current state = ' + asPair.getCurrentState());
        }

        // Update the paper
        await ctx.asList.updateASPair(asPair);
        return asPair;
    }

    async invalid(ctx, asn1 ,asn2,user) {
        // Retrieve the current paper using key fields provided
        let AsPairKey = AsPair.makeKey([asn1, asn2]);
        let asPair = await ctx.asList.getASPair(AsPairKey);

        // Validate current owner
        let mspid = ctx.clientIdentity.getMSPID();
     
        let A0=0
        let aa1=asn1.substr(asn1.indexOf('.')+1)
        let aa2=asn2.substr(asn2.indexOf('.')+1)
        if(user==aa1 || user ==aa2){A0=1}else{A0=0}
        

        if (A0!=1) {
            throw new Error('\nUser not authorized to perform transaction');
        }   
        if (mspid != asPair.getMSPID1() & mspid != asPair.getMSPID2()) {
            throw new Error('\nAS PAIR ' + asn1 + asn2  + 'cannot be modified by ' + mspid);
        }

        // First buy moves state from ISSUED to TRADING (when running )
        if (asPair.isIssued() || asPair.isVerified()) {
            asPair.setInvalid();
            asPair.setSecurityLevel(0);
        }
	 else {
            throw new Error('\nAS PAIR ' + asn1 + asn2  + ' Transaction cannot be performed. Current state = ' + asPair.getCurrentState());
        }

        // Update the paper
        await ctx.asList.updateASPair(asPair);
        return asPair;
    }

    

    
    // Query transactions

    /**
     * Query history of a commercial paper
     * @param {Context} ctx the transaction context
     * @param {String} asn1 commercial paper issuer
     * @param {Integer} asn2 paper number for this issuer
    */
	
	
    async queryHistory(ctx, asn1, asn2) {

        // Get a key to be used for History query

        let query = new QueryUtils(ctx, 'org.papernet.aspair');
        let results = await query.getAssetHistory(asn1, asn2); // (cpKey);
        return results;

    }

    /**
    * queryOwner commercial paper: supply name of owning org, to find list of papers based on owner field
    * @param {Context} ctx the transaction context
    * @param {String} owner commercial paper owner
    */
    async queryOwner(ctx, owner) {

        let query = new QueryUtils(ctx, 'org.papernet.aspair');
        let owner_results = await query.queryKeyByOwner(owner);

        return owner_results;
    }

    /**
    * queryPartial commercial paper - provide a prefix eg. "DigiBank" will list all papers _issued_ by DigiBank etc etc
    * @param {Context} ctx the transaction context
    * @param {String} prefix asset class prefix (added to paperlist namespace) eg. org.papernet.paperMagnetoCorp asset listing: papers issued by MagnetoCorp.
    */
    async queryPartial(ctx, prefix) {

        let query = new QueryUtils(ctx, 'org.papernet.aspair');
        let partial_results = await query.queryKeyByPartial(prefix);

        return partial_results;
    }

    /**
    * queryAdHoc commercial paper - supply a custom mango query
    * eg - as supplied as a param:     
    * ex1:  ["{\"selector\":{\"faceValue\":{\"$lt\":8000000}}}"]
    * ex2:  ["{\"selector\":{\"faceValue\":{\"$gt\":4999999}}}"]
    * 
    * @param {Context} ctx the transaction context
    * @param {String} queryString querystring
    */
    async queryAdhoc(ctx, queryString) {

        let query = new QueryUtils(ctx, 'org.papernet.aspair');
        let querySelector = JSON.parse(queryString);
        let adhoc_results = await query.queryByAdhoc(querySelector);

        return adhoc_results;
    }


    /**
     * queryNamed - supply named query - 'case' statement chooses selector to build (pre-canned for demo purposes)
     * @param {Context} ctx the transaction context
     * @param {String} queryname the 'named' query (built here) - or - the adHoc query string, provided as a parameter
     */
     async queryNamed(ctx, queryname) {
        let querySelector = {};
        switch (queryname) {
            case "invalid":
                querySelector = { "selector": { "currentState": 2 } };  // 2 = invalid state
                break;
            
            case "verified":
                querySelector = { "selector": { "currentState": 1 } };  // 1 = verified1 state
                break;
            case "issued":
                querySelector = { "selector": { "currentState": 0 } };  // 0 = issued state
                break;
            
            case "value":
                // may change to provide as a param - fixed value for now in this sample
                querySelector = { "selector": { "faceValue": { "$gt": 4000000 } } };  // to test, issue CommPapers with faceValue <= or => this figure.
                break;
            default: // else, unknown named query
                throw new Error('invalid named query supplied: ' + queryname + '- please try again ');
        }

        let query = new QueryUtils(ctx, 'org.papernet.aspair');
        let adhoc_results = await query.queryByAdhoc(querySelector);

        return adhoc_results;
    }

}

module.exports = AsPairContract;
