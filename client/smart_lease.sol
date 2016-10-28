pragma solidity ^0.4.0;

contract User {

    address public owner;

    function user(){
        owner = msg.sender;
        }

    function kill() onlyOwner{
        suicide(owner);
    }

    modifier onlyOwner {
        if (msg.sender != owner) {
            throw;
        } else {
            _;
        }
    }

}

contract Tenant is User {
    string public tenantName;

    mapping(address=>Lease) public leases;

    event Deposit(address from, uint value);

    struct Lease{
        bool active;
        uint lastUpdate;
        uint256 rent;
    }

    function Tenant(string _name){
        tenantName = _name;
    }


    function registerToLandlord(address _landlordAddress) onlyOwner{

        leases[_landlordAddress] = Lease({
            active: true,
            lastUpdate: now,
            rent: 0
            });
    }


    function setRent(uint256 _rent){
        if(leases[msg.sender].active){
                leases[msg.sender].lastUpdate = now;
                leases[msg.sender].rent = _rent;
            }else{
                throw;
            }
    }

    function payRent(address _landlordAddress){
        _landlordAddress.send(leases[_landlordAddress].rent);

    }

    function endLease(address _landlordAddress){
        if(leases[_landlordAddress].debt == 0){
            leases[_landlordAddress].active = false;

            }else{
                throw;
            }
    }
}

contract Landlord is User {

    string public landlordName;
    string public physicalAddress;

    event SetRent(address from, uint value);
    event SetNumber();

    function Landlord(
        string _name,
        string _physicalAddress){

        landlordName = _name;
        physicalAddress = _physicalAddress;
    }

    function setRent(uint256 _rent, address _tenantAddress){

        Tenant person = Tenant(_tenantAddress);
        person.setRent(_rent);

    }
}

// long term code - different object structure to code above, better for long run. 
// tabling for now (date Oct.2016) to focus on UI

// contract SmartLease  {
//  mapping (address => uint) public coinBalanceOf;
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
//      address public tenant;
//         uint amount
//      bool approved = false;
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

//  event leasePayment(address tenant, address landlord, uint monthlyRent);



// contract token { function transfer(address receiver, uint amount){  } }
