#!/bin/bash
echo 'installing knex and pg';
npm install --save-dev knex pg;
echo 'writing db/knex.js';
mkdir db;
touch db/knex.js;
echo 'const environment = process.env.NODE_ENV || `development`;
const knexConfig = require(`../knexfile.js`)[environment];
const knex = require(`knex`)(knexConfig);

module.exports = knex' > db/knex.js;
touch db/knexfile.js;
read -p 'Enter a db name: ' db
echo 'writing db/knexfile.js with connection to localhost/' $db;
echo 'module.exports = {
    development: {
        client: `pg`,
        connection: `postgres://localhost/'$db'`
    }
}' > db/knexfile.js;
echo 'running createdb ' $db;
createdb $db;
echo 'creating seeds and migrations directories';
read -p 'Enter a table name: ' table
echo 'running knex migrate:make create_'$table
knex migrate:make create_$table --knexfile ./db/knexfile.js;
export table;
./write-model.sh
./write-controller.sh
./write-router.sh
echo 'const express = require(`express`)
const path = require(`path`)
const resourceRouter = require(`./routes/resource`)
const '$table'Router = require(`.routes/'$table'`)

const app = express()

const port = process.env.PORT || 3000

app.use(express.static(path.join(__dirname, `public`)))
app.use(`/resource`, resourceRouter)
app.use(`/'$table', '$table'Router`)

//handle 404
app.use((req, res, next) => {
    let error = new Error(`Not found`)
    error.status = 404
    next(error)
})

//handle all errors
app.use((err, req, res, next) => {
    res.status(err.status || 500)
    res.send(err)
})

app.listen(port, () => console.log(`listening on ${port}`))

module.exports = app' > index.js;