const express = require("express")
const app = express();
const mongoose = require("mongoose")

app.get("/", (req, res) => {
    return res.json({message: "Hello"});
});

mongoose.connect("mongodb://localhost:27017/database")

app.listen(8000, () => console.log("Server started"));