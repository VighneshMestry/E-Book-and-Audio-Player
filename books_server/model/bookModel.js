const mongoose = require("mongoose");

const bookSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
    unique: true,
  },
  author: {
    type: String,
    required: true,
  },
  rating: {
    type: Number,
    required: true,
  },
  coverImageUrl: {
    type: String,
    required: true,
  },
  bookPdfUrl: {
    type: String,
    required: true,
  },
});

const Book = mongoose.model("book", bookSchema);
module.exports = Book;
