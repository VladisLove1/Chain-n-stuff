/*
*used crypto-js lib
*/

const SHA256 = require('crypto-js/sha256');

class Block {
    constructor(index, timestamp, data, previousHash = ''){
        this.index = index;
        this.timestamp = timestamp;
        this.data = data;
        this.previousHash = previousHash;
        this.hash = this.calculateHash();
    }

    calculateHash(){
        return SHA256(this.index + this.previousHash + this.timestamp + JSON.stringify(this.data)).toString();
    }
}

class Blockchain{
    constructor(){
        this.chain = [this.createGenesisBlock()];
    }

    createGenesisBlock(){
        return new Block(0, "31/01/2018", "Genesis Block", "0");
    }

    getLatestBlock(){
        return this.chain[this.chain.length - 1];
    }

    addBlock(newBlock){
        newBlock.previousHash = this.getLatestBlock().hash;
        newBlock.hash = newBlock.calculateHash();
        this.chain.push(newBlock);
    }

    isValid(){
        for(let i = 1; i < this.chain.length; i++) {
            const currentBlock = this.chain[i];
            const previousBlock = this.chain[i - 1];

            if (currentBlock.hash !== currentBlock.calculateHash()) {
                return false;
            }
            if (currentBlock.previousHash !== previousBlock.hash) {
                return false;
            }
        }
        return true;
    }

}

let DataLabChain = new Blockchain();

for(let i = 1; i < 10; i++) {
    let now = new Date();
    if(DataLabChain.isValid() == true){
        DataLabChain.addBlock(new Block(i, now.getSeconds() + 's ' + now.getMilliseconds() + 'ms ' + i.toString(), Math.random(i,100)));
    }
}

//console.log('Is Blockchain valid? ' + DataLabChain.isValid());

//DataLabChain.chain[2].data = 999;
console.log('Is Blockchain valid? ' + DataLabChain.isValid());
//console.log(JSON.stringify(DataLabChain, null, 4));
