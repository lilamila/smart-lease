// callback filter function to get the latest block, 
// .watch starts cycle of looking at incoming traffic
// function returns the blockhash of the currently new block, if there's no 
// error, we use this blockHash to get that full block (always use the async
// version so we don't freeze interface)
// Once we get the block, we just call Session.set to change the reactive 
// Session variable 'latestBlock', rerunning/updating the function in main.js
// and rerendering the template. This watch is always called if new block arrives
web3.eth.filter('latest').watch(function(e, blockHash) {
    if(!e) {
        web3.eth.getBlock(blockHash, function(e, block){
            Session.set('latestBlock', block);
        });
    }
});


web3.eth.getBalance('0x55eea8e07d2ed078eb211b8d03c5e9635e6f0011')

// check if money arrived

CreateLeaseInstance.Deposit({},{fromBlock: 0, toBlock: 'latest'}).watch(function(e, log) {
    if(!e) {
        console.log('Money arrived! From:'+ log.args.from, log.args.value.toString(10));

        // add the transaction to our collection
        Leases.upsert('tx_'+ log.transactionHash ,{
            from: log.args.from,
            value: log.args.value.toString(10),
            blockNumber: log.blockNumber
        });
    }
});


CreateLeaseInstance.setNumber(template.find('input').value, {from: web3.eth.accounts[0], gas: 50000});
        template.find('input').value = '';