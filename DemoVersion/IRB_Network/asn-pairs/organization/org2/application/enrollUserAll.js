/*
 * Copyright IBM Corp. All Rights Reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

'use strict';

const FabricCAServices = require('fabric-ca-client');
const { Wallets } = require('fabric-network');
const fs = require('fs');
const yaml = require('js-yaml');
const path = require('path');
const { promisify } = require('util')
//const sleep = promisify(setTimeout)

const readline = require('readline');

  function sleep(ms){
        return new Promise(resolve=>{
            setTimeout(resolve,ms)
        })
    }


const prompt = require('prompt-sync')();
 


//async function reading() {

//return lineReader;
//}

//lineReader=await reading()


async function main(user1) {

    //CHECK IF YOU REALLY NEED THIS SLEEP 
    
    try {
        console.log('Starting')
        // load the network configuration
        let connectionProfile = yaml.safeLoad(fs.readFileSync('../gateway/connection-org2.yaml', 'utf8'));

        // Create a new CA client for interacting with the CA.
        const caInfo = connectionProfile.certificateAuthorities['ca.org2.example.com'];
        const caTLSCACerts = caInfo.tlsCACerts.pem;
        const ca = new FabricCAServices(caInfo.url, { trustedRoots: caTLSCACerts, verify: false }, caInfo.caName);

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), '../identity/user/'+user1+'/wallet');
        const wallet = await Wallets.newFileSystemWallet(walletPath);
        //console.log(`Wallet path: ${walletPath}`);

        // Check to see if we've already enrolled the admin user.
        const userExists = await wallet.get(user1);
        if (userExists) {
            console.log('An identity for the client user "'+user1+'" already exists in the wallet');
            return;
        }

        // Enroll the admin user, and import the new identity into the wallet.
        const enrollment = await ca.enroll({ enrollmentID: user1, enrollmentSecret: user1+'pw' });
        const x509Identity = {
            credentials: {
                certificate: enrollment.certificate,
                privateKey: enrollment.key.toBytes(),
            },
            mspId: 'Org2MSP',
            type: 'X.509',
        };
        await wallet.put(user1, x509Identity);
        //console.log('Successfully enrolled client user "'+user1+'" and imported it into the wallet');

    } catch (error) {
        console.error('Failed to enroll client user "'+user1+'": ${error}');
        process.exit(1);
    }

}

//main();
//BE AWARE OF THE CORRECT FILE NAME 

async function processLineByLine() {
    const fileStream = fs.createReadStream('../../../../data/user/apnic_users.csv');
    
        const lineReader = readline.createInterface({
          input: fileStream,
          crlfDelay: Infinity
        });
        // Note: we use the crlfDelay option to recognize all instances of CR LF
        // ('\r\n') in input.txt as a single line break.
    
        for await (const line of lineReader) {
          // Each line in input.txt will be successively available here as `line`.
          console.log(`Line from file: ${line}`);
          main("asn"+line)
          await sleep(150)
        }
      }

processLineByLine()