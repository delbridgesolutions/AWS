
// Require the Faker and MongoDB libraries
const { faker } = require('@faker-js/faker');
const MongoClient = require('mongodb').MongoClient;

// Connect to the MongoDB server
const client = new MongoClient('mongodb+srv://fchaconn:Admin@cluster-test.ps2capv.mongodb.net/?retryWrites=true&w=majority');
client.connect();

// Get the database and collection
const db = client.db('db_test');
const collection = db.collection('coll_test');

// Generate 1GB of data
const data = [];
for (let i = 0; i < 1000000; i++) {
  data.push({
    name: faker.person.firstName(),
    email: faker.internet.email(),
    address: faker.location.streetAddress(),
    city: faker.location.city(),
    state: faker.location.state,
    zip: faker.location.zipCode(),
    phone: faker.phone.number(),
  });
}

// Insert the data into the collection
collection.insertMany(data, function (err, result) {
  if (err) {
    console.log(err);
  } else {
    console.log('Inserted 1GB of data into the collection');
  }

  // Close the connection to the MongoDB server
  client.close();
});