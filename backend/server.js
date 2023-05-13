// set up
const express = require("express")
const app = express()
const PORT = 5000
const sql = require('mssql');
const dotenv = require('dotenv');
dotenv.config();

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
    ["to have", "avere"], 
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

async function connectAndQuery() {
    try {
        var poolConnection = await sql.connect(config);

        console.log("Reading rows from the Table...");
        var resultSet = await poolConnection.request().query(`select * 
            from [dbo].[verbsPresent]`);

        console.log(`${resultSet.recordset.length} rows returned.`);

        // output column headers
        var columns = "";
        for (var column in resultSet.recordset.columns) {
            columns += column + ", ";
        }
        console.log("%s\t", columns.substring(0, columns.length - 2));

        // ouput row contents from default record set
        resultSet.recordset.forEach(row => {
            console.log("%s\t%s", row.english, row.italian);
        });

        // close connection only when we're certain application is finished
        poolConnection.close();
    } catch (err) {
        console.error(err.message);
    }
}

app.get("/api/db", (req, res) => {
    console.log(`Db request received at: ${new Date().getHours()}:${new Date().getMinutes()}:${new Date().getSeconds()}`)
    res.set({
        "Access-Control-Allow-Origin" : "*", 
        "Access-Control-Allow-Credentials" : true 
    })
    connectAndQuery()
})