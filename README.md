# Leafer's Smart Lease

The apartment leasing procedure is riddled with overhead. This Dapp is in development to deploy contracts to handle document creation, sign off, and rent payments. Eventually, this could be attached to a network of smart devices in the home to ensure maintenance outlined in the leasing agreement is fulfilled. Inspired by my recent apartment lease signing/notarizing headache.
Leafer's Smart Lease is created by [Marie Leaf](https://twitter.com/mariesleaf).


### Table of Contents

* [Dev Instructions](#Dev Instructions)
* [Roadmap](#roadmap)
* [Creator](#creator)
* [Concepts](#concepts)
* [Resources](#Resources)

### Dev Instructions
1. Download and update Meteor
2. Download web3 packages from [frozeman](https://github.com/frozeman/simple-dapp-example/tree/master/app/.meteor)
3. 
### Roadmap

**Front-end:**  
1. Mobile first


**Back-end (Contracts):**  
1. Identity + Reputation Contract - boolean logic and state stored in initial user registration to interact with all contracts in the app.  
2. Pre-Processing Contract  
* Ability for tenants to apply for credit check and lease application  
* Implement background check logic, ID verification
* ID updated with approval boolean   
3. Lease Contract  
* Variables defined:  
    - USD/ETH/BTC amount on lease  
    - Duration of lease  
* Ability for tenants and landlord to sign lease  
* Pay rent transfer  
    - Automatic through prefilled token  
    - Automatic through bank account integration  
    - Set reminder  
    - Register small positive to reputation contract upon payment  
4. Grievances Contract
    - If late payment, register to reputation system
    - If 1 week overdue, if 30 days overdue, if 60 days overdue dock reputation accordingly  
    - Reminder options set for landlord to text, email, call tenant or send collections agent  
5. Connected Device Contract  
    - Ability for landlord to register connected devices and change connected device maintenance clause in lease, prior to signing  
        + dishwasher, fridge, shower, toilet, air conditioning
    - Malfunction alert, logs time, nature, and sends preprogrammed message to handy man/super's communication choice  
    - Landlord reputation dock if request not fulfilled in pre agreed time  

**Fuel Structure:**  
1. Smart Lease takes x% fee per transaction to pay for gas and to smart contract developer  

### Creator
**Marie Leaf**

* <https://twitter.com/mariesleaf>
* <https://github.com/mleafer>


### Resources

[Shlomi's Tutorial](https://www.youtube.com/playlist?list=PLH4m2oS2ratdoHFEkGvwvd7TkeTv4sa7Z)  
[Dapps with Meteor](https://github.com/ethereum/wiki/wiki/Dapp-using-Meteor)  
[Web3 JS API](https://github.com/ethereum/wiki/wiki/JavaScript-API)  
[Iron Router](https://github.com/iron-meteor/iron-router)  
[TODO: check out Tradle for Identity](https://github.com/tradle/about/wiki/Identity-on-Ethereum)  