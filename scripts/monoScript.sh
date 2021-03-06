#!/bin/bash

echo 'INIT package.json';
npm init -y;
echo 'INSTALL express';
npm install --save express;
echo 'RUN dev setup';
echo 'INSTALL nodemon';
npm install --save-dev nodemon;
echo 'INSTALL dotenv';
npm install --save-dev dotenv;
echo 'INSTALL test packages';
npm install --save-dev mocha chai chai-http;
echo 'CREATE test directory';
mkdir ./test/;
echo 'CREATE project directories';
mkdir public/ routes/;
echo 'WRITE basic index.html at public/indec.html';
touch public/index.html;
echo '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
    Made by express-setup.sh
</body>
</html>'> public/index.html
echo 'WRITE generic router at /resource.js';
touch routes/resource.js;
echo 'const express = require(`express`)
const router = express.Router()

// READ ALL records for this table
router.get(`/`, (req, res, next) => {
    res.send(`ALL RECORDS`) 
})

// READ ONE record for this table
router.get(`/:id`, (req, res, next) => {
    res.send(`ONE RECORD`)
})

// CREATE ONE record for this table
router.post(`/`, (req, res, next) => {
    res.status(201).send(`CREATED RECORD`)
})

// UPDATE ONE record for this table
router.put(`/:id`, (req, res, next) => {
    res.send(`UPDATED RECORD`)
})

// DELETE ONE record for this table
router.delete(`/:id`, (req, res, next) => {
    res.send(`DELETED RECORD`)
})

module.exports = router' > routes/resource.js;
echo 'const chai = require(`chai`)
const app = require(`../index.js`)
const path = require(`path`)
const fs = require(`fs`)
const { expect } = chai

chai.use(require(`chai-http`))

describe(`index.js`, () => {
  it(`responds to a get at / with public/index.html`, (done) => {
      chai.request(app)
        .get(`/`)
        .end((err, res) => {
            expect(res.status).to.equal(200)
            expect(res.text).to.equal(fs.readFileSync(path.join(__dirname, `../public`, `index.html`), `utf-8`))
            done()
        })
  })

  it(`responds to a get at /resource with ALL RECORDS`, (done) => {
      chai.request(app)
        .get(`/resource`)
        .end((err, res) => {
            expect(res.status).to.equal(200)
	        expect(res.text).to.equal(`ALL RECORDS`)
            done()  
      })
  })

  it(`responds to a get at /resource/id with ONE RECORD`, (done) => {
      chai.request(app)
        .get(`/resource/1`)
        .end((err, res) => {
            expect(res.status).to.equal(200)
	        expect(res.text).to.equal(`ONE RECORD`)
            done()  
      })
  })

  it(`responds to a post at /resource with CREATED RECORD`, (done) => {
      chai.request(app)
        .post(`/resource`)
        .end((err, res) => {
            expect(res.status).to.equal(201)
	        expect(res.text).to.equal(`CREATED RECORD`)
            done()  
      })
  })
  
  it(`responds to a put at /resource/id with UPDATED RECORD`, (done) => {
      chai.request(app)
        .put(`/resource/1`)
        .end((err, res) => {
            expect(res.status).to.equal(200)
	        expect(res.text).to.equal(`UPDATED RECORD`)
            done()  
      })
  })
  
  it(`responds to a delete at /resource/id with DELETED RECORD`, (done) => {
      chai.request(app)
        .delete(`/resource/1`)
        .end((err, res) => {
            expect(res.status).to.equal(200)
	        expect(res.text).to.equal(`DELETED RECORD`)
            done()  
      })
  })
})' > test/index.test.js;
echo 'SET package.json scripts: "test": mocha --exit';
sed -i 's/"echo \\"Error: no test specified\\" && exit 1"/"mocha --exit"/' package.json;
echo 'SET package.json scripts: "dev": nodemon index.js'
sed -i 's/"scripts": {/"scripts": {\
    "dev": "nodemon index.js",/' package.json;
echo 'RUN interactive DB setup';
~/knex-gen/scripts/db-setup.sh;