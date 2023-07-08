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

// // post verbs
// app.post("/api/verbs/post", async (req, res) => {
//     console.log(`Request received at: ${new Date().getHours()}:${new Date().getMinutes()}:${new Date().getSeconds()} - Verbs with ending: '${req.params.ending}'`)
//     res.set({
//         "Access-Control-Allow-Origin" : "*", 
//         "Access-Control-Allow-Credentials" : true 
//     })
//     data = await runQuery(`select top 5 * from [dbo].[verbsPresent] where ending = '${req.params.ending}'`)
//     //res.send({queryData: data})
//     res.json(data)
// })

// // comment and uncomment whenever I need to restart app