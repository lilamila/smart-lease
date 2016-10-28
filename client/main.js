import { Template } from 'meteor/templating';
import { ReactiveVar } from 'meteor/reactive-var';
import './templates/main.html';


if (Meteor.isClient) {
	// define Sessions (a global reactive object in Meteor which survives hot-code pushes - http://info.meteor.com/blog/meteor-hot-code-push)
	Session.setDefault('latestBlock', {hello:'testing'}); // updated by the 'latestBlock' function in connector.js

	// helpers enable use on html
	Template.body.helpers({

		});

	// helper function that makes a query on the Leases collection
	// collections in Meteor, like Session object are reactive, once you change 
	// one document which you queried somewhere else in a reactive function, this
	// reactive function will rerun, and update the template accordingly
	// the second helper is called 'value', which is already a property of the
	// document we return
	Template['existingLeases'].helpers({
		// leases: [
		// 	{ physAddress: "286 Gangsters"}, // TODO attach to EVM /or Blockstack
		// 	{ physAddress: "The Villager"},
		// 	{ physAddress: "Milton Mansion"}
		// 	]
		leases: function(){
			return Leases.find({}, {sort: {blockNumber: -1}}); //sort to get latest block number on the top
		},
		value: function(){
			return web3.fromWei(this.value, 'ether') + 'ether'; //taking in the wei value that you got from collections, and add the string 'ether' on the end.
		}

		});

	// in this case we didn't create any helpers, we created events, these 
	// events would be scoped to that template. so we don't have to make crazy
	// selectors, just saying which button with class is good enough. 
	// note: events can't be reactive only template helpers
	Template['createNewLease'].events({
		// button with class create is like the .set class in frozeman's app
		'click button.create': function(e, template) {
			// looks at template and takes value of input field, and then need to specify
			// from which address we're transacting, which will be my primary address web3.eth.accounts[0]
        CreateLeaseInstance.setNumber(template.find('input').value, {from: web3.eth.accounts[0], gas: 50000});
        template.find('input').value = ''; //set the template value to zero, just to remove number from template
		}
	})

	Template['blockchainStatus'].helpers({
		currentBlock: function () {
			return JSON.stringify(Session.get('latestBlock'), null, 2);
		}
	});
}

if (Meteor.isServer) {
	Meteor.startup(function () {

	});
}



// Template['getContractsByUser'].helpers({

// });

// Template['createNewLease'].events({
//   'click button.create': function (e, template) {
//     alert(template.find('input').value +)
//   }


// };

// Template.hello.onCreated(function helloOnCreated() {
//   // counter starts at 0
//   this.counter = new ReactiveVar(0);
// });

// Template.hello.helpers({
//   counter() {
//     return Template.instance().counter.get();
//   },
// });

// Template.hello.events({
//   'click button'(event, instance) {
//     // increment the counter when button is clicked
//     instance.counter.set(instance.counter.get() + 1);
//   },
// });
