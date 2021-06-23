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
const prompt = require('prompt-sync')();

async function main() {
    try {
        
        const userName = prompt("Enter username, it should be the asn: ");
        console.log(`Username : ${userName}`);
        const password = prompt("Enter password: ");
        console.log(`Username : ${password}`);
        // load the network configuration
        let connectionProfile = yaml.safeLoad(fs.readFileSync('../gateway/connection-org6.yaml', 'utf8'));

        // Create a new CA client for interacting with the CA.
        const caInfo = connectionProfile.certificateAuthorities['ca.org6.example.com'];
        const caTLSCACerts = caInfo.tlsCACerts.pem;
        const ca = new FabricCAServices(caInfo.url, { trustedRoots: caTLSCACerts, verify: false }, caInfo.caName);

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), '../identity/user/asn'+userName+'/wallet');
        const wallet = await Wallets.newFileSystemWallet(walletPath);
        console.log(`Wallet path: ${walletPath}`);

        // Check to see if we've already enrolled the admin user.
        const userExists = await wallet.get(userName);
        if (userExists) {
            console.log('An identity for the client user asn'+userName+' already exists in the wallet');
            return;
        }

        // Enroll the admin user, and import the new identity into the wallet.
        const enrollment = await ca.enroll({ enrollmentID: 'asn'+userName, enrollmentSecret: 'asn'+password });
        const x509Identity = {
            credentials: {
                certificate: enrollment.certificate,
                privateKey: enrollment.key.toBytes(),
            },
            mspId: 'Org6MSP',
            type: 'X.509',
        };
        await wallet.put('asn'+userName, x509Identity);
        console.log('Successfully enrolled client user asn'+userName+' and imported it into the wallet');

    } catch (error) {
        console.error('Failed to enroll client user '+userName+': ${error}');
        process.exit(1);
    }
}

main();
