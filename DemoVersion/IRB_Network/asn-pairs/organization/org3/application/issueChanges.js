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
 * 4. Construct request to issue commercial paper
 * 5. Submit transaction
 * 6. Process response
 */

'use strict';

// Bring key classes into scope, most importantly Fabric SDK network class
const fs = require('fs');
const yaml = require('js-yaml');
const { Wallets, Gateway } = require('fabric-network');
const AsPair = require('../contract/lib/aspair.js');
const { promisify } = require('util')
//const sleep = promisify(setTimeout)

const prompt = require('prompt-sync')();

const readline = require('readline');

  function sleep(ms){
        return new Promise(resolve=>{
            setTimeout(resolve,ms)
        })
    }


function EvaluateOrg(o1) {
    if(o1=="AFRINIC") return "Org1."
    if(o1=="APNIC") return "Org2."
    if(o1=="ARIN") return "Org3."
    if(o1=="LACNIC") return "Org4."
    if(o1=="RIPE") return "Org5."
  }


// Main program function
async function main(user1,user2,o1,o2,rel) {


    const wallet = await Wallets.newFileSystemWallet('../identity/user/'+user1+'/wallet');

    // A gateway defines the peers used to access Fabric networks
    const gateway = new Gateway();

    try {

     //A wallet stores a collection of identities for use
   


        // Specify userName for network access
        // const userName = 'isabella.issuer@magnetocorp.com';
        const userName = user1;

        // Load connection profile; will be used to locate a gateway
        let connectionProfile = yaml.safeLoad(fs.readFileSync('../gateway/connection-org3.yaml', 'utf8'));

        // Set connection options; identity and wallet
        let connectionOptions = {
            identity: userName,
            wallet: wallet,
            discovery: { enabled:true, asLocalhost: true }
        };

        // Connect to gateway using application specified parameters
        //console.log('Connect to Fabric gateway.');

        await gateway.connect(connectionProfile, connectionOptions);

        // Access PaperNet network
        //console.log('Use network channel: mychannel.');

        const network = await gateway.getNetwork('mychannel');

        // Get addressability to commercial paper contract
        //console.log('Use org.papernet.asn_pair smart contract.');

        const contract = await network.getContract('aspaircontract');

        // issue commercial paper
        //console.log('Submit asn_pair issue transaction.');

        const issueResponse = await contract.submitTransaction('issue', o1+user1, o2+user2, rel, parseInt(1), userName);

        // process response
        //console.log('Process issue transaction response.'+issueResponse);

        let asPair = AsPair.fromBuffer(issueResponse);

        console.log(` as Pair : successfully issued for ASN Pair:  ${asPair.asn1} , ${asPair.asn2} `);
        //console.log('Transaction complete.');

    } catch (error) {

        console.log(`Error processing transaction. ${error}`);
        //console.log(error.stack);

    } finally {

        // Disconnect from the gateway
        //console.log('Disconnect from Fabric gateway.');
        gateway.disconnect();

    }    
    
}


const year = prompt(" Enter Year: 2015 : 2016 : 2017 : 2018 : 2019 : 2020 : 2021 :");
console.log(`Choosed Year:  ${year}`);



async function processLineByLine() {
    const fileStream = fs.createReadStream('../../../../data/rel/changes/arin/arin_'+year+'_changes.csv');
    
        const lineReader = readline.createInterface({
          input: fileStream,
          crlfDelay: Infinity
        });
        // Note: we use the crlfDelay option to recognize all instances of CR LF
        // ('\r\n') in input.txt as a single line break.
    
        for await (const line of lineReader) {
          // Each line in input.txt will be successively available here as `line`.
          //console.log(`Line from file: ${line}`);
          var res = line.split(" ");
          var user1= "asn"+res[0];
          //console.log(user1)
          var user2= "asn"+res[1];
          //console.log(user2)
          var rel= res[4];
          //console.log(rel)
          let o1=EvaluateOrg(res[2])
          let o2=EvaluateOrg(res[3])
          await main(user1,user2,o1,o2,rel)
          //await sleep(150)
        }
      }

processLineByLine()