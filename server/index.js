const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const AuthRoutes = require("./routes/AuthRoute");
const StudentRoutes = require("./routes/StudentRoute");
require("dotenv").config();
require("./config/dbConfig");

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const port = process.env.PORT || 8080;

const ApiBasePath = "/api/v1";

app.get("/", (req, res) => {
  res.status(200).json({ message: "Welcome to GradEase" });
});

app.use(ApiBasePath, AuthRoutes);

app.use(ApiBasePath, StudentRoutes);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
