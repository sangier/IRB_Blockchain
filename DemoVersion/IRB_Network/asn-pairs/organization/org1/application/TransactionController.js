var execSync = require('sync-exec');
const fs = require('fs');
const yaml = require('js-yaml');
const { Wallets, Gateway } = require('fabric-network');
const AsPair = require('../contract/lib/aspair.js');
const { promisify } = require('util')
//const sleep = promisify(setTimeout)
const {performance} = require('perf_hooks');
const prompt = require('prompt-sync')();
const readline = require('readline');
const process = require('process');
const shell = require('shelljs')

  function sleep(ms){
        return new Promise(resolve=>{
            setTimeout(resolve,ms)
        })
    }



const year = prompt(" Enter Year: 2015 : 2016 : 2017 : 2018 : 2019 : 2020 : 2021 :");
console.log(`Choosed Year : ${year}`);
let dir='../../../../data/rel/new/afrinic/'+year+'/'

async function MainProcessLineByLine() {

  var files = fs.readdirSync(dir);
  let nT=0
  let nTbatch=2500
  console.log(dir)
  console.log(files)
  let t1=performance.now()
  for  (let i=0; i<files.length; i++){
        
    console.log("Opening File: "+files[i])
    console.log("File Number: "+i+" out of "+files.length)
    console.log("Completed %: "+(100/files.length)*i)
    console.log("Completed Transaction : "+(nT))
    var user = execSync('node issueNew.js '+dir+files[i]+' '+nT);
    shell.exec('/home/sangieri/6OrgNetwork/myNetwork/asn-pairs/read.sh')


    nT=nT+nTbatch
  //   fs.unlink(dir+files[i], function (err) {
  //     if (err) throw err;
  //     // if no error, file has been deleted successfully
  //     console.log('File '+dir+files[i]+'deleted!');
  // });
  }
  let t2= performance.now()
  let t=t2-t1 
  var stream = fs.createWriteStream("../../../../data/log/InsertionTime"+year+".txt", {'flags': 'a'});
              stream.once('open', function(fd) {
                          stream.write('afrinic,'+nT+","+t+"\r\n");
        
                        });


}


MainProcessLineByLine()
  
  