const express = require("express");
const app = express();
const bodyParser = require("body-parser");

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const port = 1234;

const apiKeyMiddleware = (req, res, next) => {
    const apiKey = req.headers['x-api-key']; 
    if (apiKey === 'lvdaekatoken') {
      next();
    } else {
      res.status(401).json({ error: 'Unauthorized. Invalid API key.' });
    }
};
  

app.use(apiKeyMiddleware);


app.get('/getUser', apiKeyMiddleware, (req, res) => {
    res.json({ message: 'GET User API called successfully.' });
});









app.get("/", apiKeyMiddleware, (req, res) => {
    res
        .status(200)
        .json({ message: "Welcome bru" });
});
  

  
app.post("/login", (req, res) => {
  const data = req.body;
  if (data.email == "admin@gradease.com") {
    res.status(200).json({ message: "Successfully logined" });
  } else {
    res.status(401).json({ message: "Unauthorized" });
  }
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
