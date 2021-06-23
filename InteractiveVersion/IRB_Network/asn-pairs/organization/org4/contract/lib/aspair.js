/*
 * Copyright IBM Corp. All Rights Reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

'use strict';

// Utility class for ledger state
const State = require('../ledger-api/state.js');

// Enumerate commercial paper state values
const cpState = {
    ISSUED: 0,
    VERIFIED: 1,
    INVALID: 2
};



/**
 * CommercialPaper class extends State class
 * Class will be used by application and smart contract to define a paper
 */
class AsPair extends State {

    constructor(obj) {
        super(AsPair.getClass(), [obj.asn1, obj.asn2]);
        Object.assign(this, obj);
    }

    /**
     * Basic getters and setters
    */

    getIssuer() {
        return this.issuer;
    }

    setIssuer(newIssuer) {
        this.issuer = newIssuer;
    }

    getAsn1() {
        return this.asn1;
    }

    setAsn1(newIssuer) {
        this.asn1 = newIssuer;
    }
	
    getAsn2() {
        return this.asn2;
    }

    setAsn2(newIssuer) {
        this.asn2 = newIssuer;
    }

    getRelationship() {
        return this.relationship;
    }

    setRelationship(newIssuer) {
        this.relationship = newIssuer;
    }	


    getSecurityLevel() {
        return this.SecurityLevel;
    }

    setSecurityLevel(newIssuer) {
        this.SecurityLevel = newIssuer;
    }

    getMSPID1() {
        return (this.asn1.substr(0,this.asn1.indexOf('.'))+"MSP");
         
    }

    getMSPID2() {
        return (this.asn2.substr(0,this.asn2.indexOf('.'))+"MSP");
    }

    getOwner() {
        return this.owner;
    }

    setOwner(newOwner) {
        this.owner = newOwner;
    }


    getOwnerMSP() {
        return this.mspid;
    }
    setOwnerMSP(mspid) {
        this.mspid = mspid;
    }

    
    /**
     * Useful methods to encapsulate commercial paper states
     */

     setIssued() {
        this.currentState = cpState.ISSUED;
    }

    setVerified() {
        this.currentState = cpState.VERIFIED;
    }

    setInvalid() {
        this.currentState = cpState.INVALID;
    }


    isIssued() {
        return this.currentState === cpState.ISSUED;
    }

	
    isVerified() {
        return this.currentState === cpState.VERIFIED;
    }


    isInvalid() {
        return this.currentState === cpState.INVALID;
    }

    static fromBuffer(buffer) {
        return AsPair.deserialize(buffer);
    }

    toBuffer() {
        return Buffer.from(JSON.stringify(this));
    }

    /**
     * Deserialize a state data to commercial paper
     * @param {Buffer} data to form back into the object
     */
    static deserialize(data) {
        return State.deserializeClass(data, AsPair);
    }

    /**
     * Factory method to create a commercial paper object   DO I NEED THE ISSUER 
     */
    static createInstance(asn1, asn2) {
        return new AsPair({asn1, asn2});
    }

    static getClass() {
        return 'org.papernet.aspair';
    }
}

module.exports = AsPair;
