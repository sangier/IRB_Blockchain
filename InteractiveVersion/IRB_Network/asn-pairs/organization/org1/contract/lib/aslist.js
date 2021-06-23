/*
 * Copyright IBM Corp. All Rights Reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
*/

'use strict';

// Utility class for collections of ledger states --  a state list
const StateList = require('../ledger-api/statelist.js');

const AsPair = require('./aspair.js');

class AsList extends StateList {

    constructor(ctx) {
        super(ctx, 'org.papernet.aspair');
        this.use(AsPair);
    }

    async addASPair(aspair) {
        return this.addState(aspair);
    }

    async getASPair(aspairKey) {
        return this.getState(aspairKey);
    }

    async updateASPair(aspair) {
        return this.updateState(aspair);
    }
}


module.exports = AsList;
