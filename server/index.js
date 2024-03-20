const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const AuthRoutes = require("./routes/AuthRoute");
require("dotenv").config();
require("./config/dbConfig");

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const port = process.env.PORT || 8080;

app.get("/", (req, res) => {
  res.status(200).json({ message: "" });
});

app.use("/api/v1", AuthRoutes);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
