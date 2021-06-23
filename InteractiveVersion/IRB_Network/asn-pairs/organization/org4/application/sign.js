/*
 * Copyright IBM Corp. All Rights Reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

/*
 * This application has 6 basic steps:
 * 1. Select an identity from a wallet
 * 2. Connect to network gateway
 * 3. Access PaperNet network
 * 4. Construct request to transfer commercial paper
 * 5. Submit transaction
 * 6. Process response
 */

'use strict';

// Bring key classes into scope, most importantly Fabric SDK network class
const fs = require('fs');
const yaml = require('js-yaml');
const { Wallets, Gateway } = require('fabric-network');
const AsPair = require('../contract/lib/aspair.js');
const prompt = require('prompt-sync')();

// Main program function
async function main() {

    // A wallet stores a collection of identities for use
    const resp = prompt("Have You issued the AS Pair? Type Uppercase Y or N: ");
    console.log(`Username : ${resp}`);

    const username = prompt("Enter username, it should be the asn: ");
    console.log(`Username : ${username}`);
    // A wallet stores a collection of identities for use
    const userName='asn'+username
    const wallet = await Wallets.newFileSystemWallet('../identity/user/asn'+username+'/wallet');

    // A gateway defines the peers used to access Fabric networks
    const gateway = new Gateway();

    // Main try/catch block
    try {

       
        // Load connection profile; will be used to locate a gateway
        let connectionProfile = yaml.safeLoad(fs.readFileSync('../gateway/connection-org4.yaml', 'utf8'));

        // Set connection options; identity and wallet
        let connectionOptions = {
            identity: userName,
            wallet: wallet,
            discovery: { enabled:true, asLocalhost: true }
        };

        // Connect to gateway using application specified parameters
        console.log('Connect to Fabric gateway.');

        await gateway.connect(connectionProfile, connectionOptions);

        // Access PaperNet network
        console.log('Use network channel: mychannel.');

        const network = await gateway.getNetwork('mychannel');

        
        const contract = await network.getContract('aspaircontract');

        // transfer commercial paper
        
        console.log("Org1=afrinic\nOrg2=apnic\nOrg3=arin\nOrg4=lacnic\nOrg5=ripe\n")
        const org1 = prompt("Please enter First asn Organization: " );
        console.log(`Selected Org : ${org1}`);
        
        console.log("Org1=afrinic\nOrg2=apnic\nOrg3=arin\nOrg4=lacnic\nOrg5=ripe\n")
        const org2 = prompt(" Please enter Second asn Organization: ");

        console.log(`Selected Org : ${org2}`);
        const userName2 = prompt("Please enter Second asn number: ");
        console.log(`Selected Org : ${userName2}`);
        
        let transferResponse="";
        

        if(resp=='N'){
         transferResponse = await contract.submitTransaction('sign', org2+'.asn'+userName2, org1+'.asn'+username,userName);
        console.log('Process transfer transaction response.'+ transferResponse);
    
    }

        if(resp=='Y'){
         transferResponse = await contract.submitTransaction('sign', org1+'.asn'+username, org2+'.asn'+userName2,userName);
            console.log('Process transfer transaction response.'+ transferResponse);

        }
            

        // process response
        
        let asPair = AsPair.fromBuffer(transferResponse);

        console.log(`ASN PAIR  : ${asPair.asn1}, ${asPair.asn2} successfully signed by both ASes owners`);
        console.log('Transaction complete.');

    } catch (error) {

        console.log(`Error processing transaction. ${error}`);
        console.log(error.stack);

    } finally {

        // Disconnect from the gateway
        console.log('Disconnect from Fabric gateway.');
        gateway.disconnect();

    }
}
main().then(() => {

    console.log('Transfer program complete.');

}).catch((e) => {

    console.log('Transfer program exception.');
    console.log(e);
    console.log(e.stack);
    process.exit(-1);

});
