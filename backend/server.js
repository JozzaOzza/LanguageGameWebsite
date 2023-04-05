// set up
const express = require("express")
const app = express()
const PORT = 5000
const date = new Date()

app.listen(
    PORT,
    () => console.log(`Express server is listening on port number: ${PORT}`)
)

// data
const italianWords = [
    ["hello", "ciao"], 
    ["however", "ciononostante"], 
    ["but", "ma"], 
    ["and", "e"], 
    ["after", "dopo"]
]

const italianVerbs = [
    ["to have", "essere"], 
    ["to be able to", "potere"], 
    ["to do", "fare"], 
    ["to go", "andare"], 
    ["to see", "vedere"]
]

// requests/responses
app.get("/api/nouns", (req, res) => {
    res.set({
        "Access-Control-Allow-Origin" : "*", 
        "Access-Control-Allow-Credentials" : true 
    })
    res.json({"words": italianWords})
    console.log(`Nouns request received at: ${new Date().getHours()}:${new Date().getMinutes()}:${new Date().getSeconds()}`)
})

app.get("/api/verbs", (req, res) => {
    res.set({
        "Access-Control-Allow-Origin" : "*", 
        "Access-Control-Allow-Credentials" : true 
    })
    res.json({"words": italianVerbs})
    console.log(`Verbs request received at: ${new Date().getHours()}:${new Date().getMinutes()}:${new Date().getSeconds()}`)
})