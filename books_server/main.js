const express = require("express");
const app = express();
const mongoose = require("mongoose");

const bookRouter = require("./routes/bookRoutes");

app.use(express.json());
app.use("/book", bookRouter);

app.get("/", (req, res) => {
  return res.json({ message: "Hello" });
});

mongoose
  .connect("mongodb://books_db:27017/database")
  .then(() => console.log("MongoDB connected"))
  .catch((e) => console.log(e));

app.listen(8000, () => console.log("Server started"));
