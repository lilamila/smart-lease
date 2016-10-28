// can be run on server or client, if run on client, creates minimongo connection (only in memory/local storage)
// pass in 'null' for connection to keep local
// with the addition of package 
Deposits = new Mongo.Collection('deposits', {connection:null});
new PersistentMinimongo(Deposits);

Leases = new Mongo.Collection('leases', {connection:null});
new PersistentMinimongo(Leases);