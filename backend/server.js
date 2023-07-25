// set up
const express = require("express")
const app = express()
const PORT = 5000
const sql = require('mssql');
const dotenv = require('dotenv');
dotenv.config();

app.listen(
    PORT,
    () => console.log(`Express server is listening on port number: ${PORT}`)
)

// comment and uncomment whenever I need to restart app

// database config
const config = {
    user: `${process.env.SQL_SERVER_USERNAME}`, // better stored in an app setting such as process.env.DB_USER
    password: `${process.env.SQL_SERVER_PASSWORD}`, // better stored in an app setting such as process.env.DB_PASSWORD
    server: `${process.env.SQL_SERVER_NAME}`, // better stored in an app setting such as process.env.DB_SERVER
    database: `${process.env.SQL_SERVER_DB_NAME}`, // better stored in an app setting such as process.env.DB_NAME
    authentication: {
        type: 'default'
    },
    options: {
        encrypt: true
    }
}

// set up database connection
async function runQuery(query) {
    await sql.connect(config).then( async (pool) => {
        result = await pool.query(query)
    })
    return result;
}

// get verbs by ending
app.get("/api/verbs/:ending", async (req, res) => {
    console.log(`Get request at ${new Date().getHours()}:${new Date().getMinutes()}:${new Date().getSeconds()} - Verbs with ending '${req.params.ending}'`)
    res.set({
        "Access-Control-Allow-Origin" : "*", 
        "Access-Control-Allow-Credentials" : true 
    })
    data = await runQuery(`select top 10 * from [dbo].[verbsPresent] where ending = '${req.params.ending}' order by newid()`)
    //res.send({queryData: data})
    res.json(data)
})

// get nouns by topic
app.get("/api/nouns/:topic", async (req, res) => {
    console.log(`Get request at ${new Date().getHours()}:${new Date().getMinutes()}:${new Date().getSeconds()} - Nouns with topic '${req.params.topic}'`)
    res.set({
        "Access-Control-Allow-Origin" : "*", 
        "Access-Control-Allow-Credentials" : true 
    })
    data = await runQuery(`select top 10 * from [dbo].[nouns] where category = '${req.params.topic}' order by newid()`)
    //res.send({queryData: data})
    res.json(data)
})

// get adverbs by topic
app.get("/api/adverbs/:topic", async (req, res) => {
    console.log(`Get request at ${new Date().getHours()}:${new Date().getMinutes()}:${new Date().getSeconds()} - Adverbs with topic '${req.params.topic}'`)
    res.set({
        "Access-Control-Allow-Origin" : "*", 
        "Access-Control-Allow-Credentials" : true 
    })
    data = await runQuery(`select top 10 * from [dbo].[adverbs] where category = '${req.params.topic}' order by newid()`)
    //res.send({queryData: data})
    res.json(data)
})

// get adjectives by topic
app.get("/api/adjectives/:topic", async (req, res) => {
    console.log(`Get request at ${new Date().getHours()}:${new Date().getMinutes()}:${new Date().getSeconds()} - Adjectives with topic '${req.params.topic}'`)
    res.set({
        "Access-Control-Allow-Origin" : "*", 
        "Access-Control-Allow-Credentials" : true 
    })
    data = await runQuery(`select top 10 * from [dbo].[adjectives] where category = '${req.params.topic}' order by newid()`)
    //res.send({queryData: data})
    res.json(data)
})