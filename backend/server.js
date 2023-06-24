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

// requests/responses
app.get("/api/verbs", async (req, res) => {
    console.log(`Db request received at: ${new Date().getHours()}:${new Date().getMinutes()}:${new Date().getSeconds()}`)
    res.set({
        "Access-Control-Allow-Origin" : "*", 
        "Access-Control-Allow-Credentials" : true 
    })
    data = await runQuery(`select top 5 * from [dbo].[verbsPresent]`)
    //res.send({queryData: data})
    res.json(data)
})