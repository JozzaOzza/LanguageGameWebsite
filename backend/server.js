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

// test endpoint
app.get("/api/hello", (req, res) => {
    console.log(`GET - hello - ${new Date().getHours()}:${new Date().getMinutes()}:${new Date().getSeconds()}`)
    res.status(200).send("Hello, you've reached the Language Game Website backend")
    throw new Error('Your request to the /hello endpoint failed')
})

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
    console.log(`GET - Verbs with ending '${req.params.ending}' - ${new Date().getHours()}:${new Date().getMinutes()}:${new Date().getSeconds()}`)
    res.set({
        "Access-Control-Allow-Origin" : "*", 
        "Access-Control-Allow-Credentials" : true 
    })
    data = await runQuery(`select top 10 * from [dbo].[verbsPresent] where ending = '${req.params.ending}' order by newid()`)
    //res.send({queryData: data})
    res.json(data)
})

// get nouns by topic
app.get("/api/:type/:topic", async (req, res) => {
    console.log(`GET - type '${req.params.type}' with topic '${req.params.topic}' - ${new Date().getHours()}:${new Date().getMinutes()}:${new Date().getSeconds()}`)
    res.set({
        "Access-Control-Allow-Origin" : "*", 
        "Access-Control-Allow-Credentials" : true 
    })
    data = await runQuery(`select top 10 * from [dbo].[${req.params.type}] where category = '${req.params.topic}' order by newid()`)
    //res.send({queryData: data})
    res.json(data)
})