const express = require(`express`)
const path = require(`path`)
const bodyParser = require('body-parser')
const '$table'Router = require(`./routes/'$table'`)

const app = express()

const port = process.env.PORT || 3000

app.use(bodyParser.json())
app.use(express.static(path.join(__dirname, `public`)))
app.use(`/'$table'`, '$table'Router)

//handle 404
app.use((req, res, next) => {
    let error = new Error('Not found')
    error.status = 404
    next(error)
})

//handle all errors
app.use((err, req, res, next) => {
    res.status(err.status || 500)
    res.send(err)
})

app.listen(port, () => console.log(`listening on ${port}`))

module.exports = app
