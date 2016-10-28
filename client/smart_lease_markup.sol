// contract interaction tutorial: https://www.youtube.com/watch?v=m9Zb49RNGis&t=13s

// set up personas
contract User {

    address public owner;

    function user(){ //no arguments for constructor. constructor runs on deploy, and then never again. constructors cost gas to run
        owner = msg.sender; //constructor will take address of sender of contract and assign into variable we just created
        } //msg is predefined object in sol and sender means address of sender so compiler knows to take my address and assign it into public owner variable
    
    function kill() onlyOwner{
        suicide(owner); //specify address to send ether back to upon user deletion
    }

    //shlomi's modifiers: https://youtu.be/FGnv8Vfu9bY?list=PLH4m2oS2ratdoHFEkGvwvd7TkeTv4sa7Z
    modifier onlyOwner{ //http://ethereum.stackexchange.com/questions/8958/solidity-compile-error-expected-primary-expression
        if (msg.sender != owner){
            throw;
        }else{
            _;
        }
    }

}

contract Tenant is User {
    string public tenantName;

    mapping(address=>Lease) public leases;
     // mapping allows one type of variable as an index for an array, 
     // this mapping is mapping address of landlord, so instead of looking forlease1,2,3,  
     // we can look for lease that corresponds to the landlord address
    struct Lease{ //construct an object with multiple types of variables
        bool active;
        uint lastUpdate; //timestamp of last time interacted with Lease
        uint256 rent; //important to set to 256 bytes
    }

    function Tenant(string _name){
        tenantName = _name;
    }

    //onlyOwner is a modifier (refer to the modifier in User)
    function registerToLandlord(address _landlordAddress) onlyOwner{
        //map to array of leases, and update to a cell which will contain a Lease object
        leases[_landlordAddress] = Lease({
            active: true,
            lastUpdate: now,
            rent: 0
            });
    }

    // ensure priviledge to set debt given to landlord (or lease in later version)
    //takes the _landlordAddress from the Landlord function so can completely remove 'address _landlordAddress' from the arguments, and replaces with msg.sender
    function setRent(uint256 _rent){ //address used as a index/pointer to our lease struct
        if(leases[msg.sender].active){ //leases[] points to leases array in prior contract mapping, msg.sender pulls lanlord address 
            //(replaced _provideraddress with msg.sender after set up the setRent function in the Landlord contract below - address of sender, will be address of Landlord contract bc
            //this function now cannot really be used by the Tenant themselves, but the Landlord can use this function by declaring new object of Tenant functionality but on Tenant address)
                leases[msg.sender].lastUpdate = now;
                leases[msg.sender].rent = _rent;
            }else{
                throw;
            }
    }

    function payRent(address _landlordAddress){
        _landlordAddress.send(leases[_landlordAddress].rent);

    }
}

contract Landlord is User {

    string public landlordName;
    string public physicalAddress;

    event SetRent(address from, uint value);
    event SetNumber();
    //events allow convenient usage of EVM logging facilities, which in turn can be used to
    //call JS callbacks in US of dapp, which listen to these events
    // https://solidity.readthedocs.io/en/latest/contracts.html#events

    function Landlord(
        string _name,
        string _physicalAddress){

        landlordName = _name;
        physicalAddress = _physicalAddress;
    }
    //refer to tutorial: https://www.youtube.com/watch?v=m9Zb49RNGis&t=13s
    function setRent(uint256 _rent, address _tenantAddress){ //address used as pointer to Lease struct
        // create new Tenant object with name 'person' (can call whatever you want)
        // inherits/gets all functionality of the Tenant object, which is deployed on the _tenantAddress
        // so now this Landlord contract can directly interact with this Tenant contract, (on _tenantAddress)
        // and does so using this person object
        Tenant person = Tenant(_tenantAddress);
        person.setRent(uint256 _rent); //setRent function refers to tenant setRent function defined in the Tenant contract

    }
}



// long term code - different object structure to code above, better for long run. 
// tabling for now (date Oct.2016) to focus on UI

// set up SmartLease contract

// contract SmartLease  {
// 	mapping (address => uint) public coinBalanceOf;
//     uint monthlyRentInEthers;
//     uint monthsDuration;
//     bool leaseCompleted = false;
//     token addressOfTokenUsedForRent

//     event StartLease(address tenant, address landlord, uint date);

//     struct Landlord {
//         address public landlord;

//     }
//     /* data structure to hold information about lease tenants*/
//     struct Tenant {
//     	address public tenant;
//         uint amount
//     	bool approved = false;
//     }

//     /* at initialization, setup the landlord with lease constructors*/
//     function SmartLease(
//         address _ifLeaseSignedSendTo,
//         uint _monthlyRentInEthers,
//         uint _monthsDuration, //set to array
//         uint _etherCostofTenantSigning,
//         token addressOfTokenUsedForRent
//         ){
//         landlord = _ifLeaseSignedSendTo;
//         monthlyRent = _monthlyRentInEthers * 1 ether;
//         deadlines[] =  //iterate loop to for payment schedule
//         signingPrice = _etherCostofTenantSigning * 1 ether;
//         tokenReimbursement = token(addressOfTokenUsedForReimbursement);
//     }
//     /* The anonymous function is the default called whenever anyone sends funds to the contract */
//     function () {
//         if (leaseCompleted) throw;
//         uint amount = msg.value;
//         tenants[tenants.length++] = Tenant({addr: msg.sender, amount: amount});
//         amountPaid += amount;
//         tokenReimbursement.transfer(msg.sender, amount/price)
//         StartLease(msg.sender, Landlord(), now)
//     }

//     /* lease signing */
//     function signLease(string _signature) public {
//         signature = _signature;
//     }

//     event signLease(address tenant, address landlord, string _signature);

//     token.sendCoin.sendTransaction(eth.accounts[1], 1000, {from: eth.accounts[0]})

//     /* monthly payment function takes timestamp as argument */
//     function payRent(address landlord, uint _monthlyRent) returns(bool sufficient) {
//         if (coinBalanceof[msg.sender] < _monthlyRent) return false;
//         //add if statement to ensure monthlyRent payment not already paid for month
//         //add timestamp to payment(?)
//         coinBalanceOf[msg.sender] -= _monthlyRent;
//         coinBalanceOf[landlord] += _monthlyRent;
//         leasePayment(msg.sender, landlord, _monthlyRent); 
//         return true;
// }

// 	event leasePayment(address tenant, address landlord, uint monthlyRent);



// contract token { function transfer(address receiver, uint amount){  } }

