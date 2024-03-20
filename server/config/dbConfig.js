const mongoose = require('mongoose');

const url = process.env.MONGO_DB_URL;
mongoose.connect(url)
.then(() => {
    console.log("MongoDB Connected.");
}).catch((ex)=>{
    console.log("Error while establishing db connection",ex);
})