const { Router } = require("express");
const router = Router();
const mongoose = require("mongoose")
const Book = require("../model/bookModel")

router.get("/get-books", async (req, res) => {
    const books = await Book.find();
    return res.json(books);
});

router.post("/add-book", async(req, res) => {
    await Book.create({
        title: req.body.title,
        author: req.body.author,
        rating: req.body.rating,
        coverImageUrl: req.body.coverImageUrl,
        bookPdfUrl: req.body.bookPdfUrl
    })

    return res.json({message: "Book added successfully"});
});

module.exports = router;