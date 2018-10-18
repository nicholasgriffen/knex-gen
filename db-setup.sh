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
read -p 'Enter a migration name: ' migration
echo 'running knex migrate:make ' $migration
knex migrate:make $migration;