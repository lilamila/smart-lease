/**
Template Controllers

@module Templates
*/

/**
The accounts template

@class [template] components_diagnostics
@constructor
*/


Template['footer'].created = function() {
    this.updateBalance = Meteor.setInterval(function() {
        if(!Session.get('connected'))
            return;
            
        var blockNumber = web3.eth.blockNumber;
        Session.set("blockNumber", blockNumber);

        /*
        web3.eth.getBalance(web3.coinbase, function(err, result){
            var balance = result;
            var originalBalance = web3.toDecimal(balance);
            Session.set("balance", balance.toString(10));
		*/
       
	}, 1 * 1000);
};


Template['footer'].helpers({
	/**
    Get the number of accounts.

    @method (accountCount)
    */
    
	'accountCount': function(){
		return app.web3().accounts.length;
	},  
    
	/**
    Get whether web3 object exists.

    @method (web3Exists)
    */
    
	'web3Exists': function(){
		return (!_.isEmpty(app.web3()) ? 'True' : 'False');
	},
    
	/**
    Get whether web3 object exists.

    @method (web3Exists)
    */
    
	'balance': function(){
		return web3.fromWei(Session.get('balance'), 'ether').toString(10) + ' ' + 'ether';
	},

	/**
    Get coinbase address.

    @method (coinbase)
    */
    
	'coinbase': function(){
		return String(app.web3().coinbase).substr(0, 9);
	},

	/**
    See if client is listening.

    @method (listening)
    */
    
	'listening': function(){
		return app.web3().listening;
	},

	/**
    Get number of peers.

    @method (peerCount)
    */
    
	'peerCount': function(){
		return app.web3().peerCount;
	},

	/**
    Get gas price.

    @method (gasPrice)
    */
    
	'gasPrice': function(){
		return app.web3().gasPrice;
	},

	/**
    Get version.

    @method (version)
    */
    
	'version': function(){
		return app.web3().version;
	},

    
	/**
    Get default block number. (Not working for Go Eth Cli).

    @method (defaultBlock)
    */
    
	'defaultBlock': function(){
		return app.web3().defaultBlock;
	},

	/**
    Get present block number.

    @method (blockNumber)
    */
    
	'blockNumber': function(){
		return Session.get('blockNumber');
	},

	/**
    Get whether mining is turned on.

    @method (mining)
    */
    
	'mining': function(){
		return app.web3().mining;
	},
});