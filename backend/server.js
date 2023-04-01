const express = require("express")
const app = express()
const PORT = 5000
const date = new Date()
let time = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds()

const italianWords = [
    ["hello", "ciao"], 
    ["however", "ciononostante"], 
    ["but", "ma"], 
    ["and", "e"], 
    ["after", "dopo"]
]

app.get("/api", (req, res) => {
    res.json({"words": italianWords})
    console.log(`Request received at: ${new Date().getHours()}:${new Date().getMinutes()}:${new Date().getSeconds()}`)
})

app.listen(
    PORT,
    () => console.log(`Express server is listening on port number: ${PORT}`)
)