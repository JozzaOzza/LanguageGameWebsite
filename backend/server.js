const express = require("express")
const app = express()
const PORT = 5000

const italianWords = [
    ["hello", "ciao"], 
    ["however", "ciononostante"], 
    ["but", "ma"], 
    ["and", "e"], 
    ["after", "dopo"]
]

app.get("/api", (req, res) => {
    res.json({"words": italianWords})
})

app.listen(
    PORT,
    () => console.log(`Express server is listening on port number: ${PORT}`)
)