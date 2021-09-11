// configure express
const express = require("express");
const app = express();

// configure MongoDB, mongoose and the things required
const bodyParser = require("body-parser");
const mongoose = require("mongoose");
const db = require("./config/keys").mongoURI;
const Post = require("./models/Post");
const User = require("./models/User");

// configure GraphQL and schema remember the capitalization of `GraphQL`!
const expressGraphQL = require("express-graphql");
const schema = require("./schema/schema");
 
mongoose
  .connect(db, { useNewUrlParser: true })
  .then(() => console.log("Connected to MongoDB successfully"))
  .catch(err => console.log(err));

// using the bodyParser package to parse incoming requests into json
app.use(bodyParser.json());

// this is our connection to GraphQL - it takes the schema we configured as an argument 
// in the object passed to the expressGraphQL function
app.use('/graphql', expressGraphQL({
  schema,
  // allowing us to use GraphiQL in a dev environment
  graphiql: true
}));

app.listen(5000, () => console.log("Server is running on port 5000"));