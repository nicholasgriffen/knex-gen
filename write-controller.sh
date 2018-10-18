touch controllers/$table.js

echo 'WRITE CONTROLLER controllers/'$table'.js'
echo 'const model = require(`../models/'$table'`)
const controller = {
    create(req, res, next) {
        return model.create(req.body)
            .then(record => res.status(201).send(record))
            .catch(err => next({ status: 422, message: `Unable to process create`, caught: err }))
    },
    readAll(req, res, next) {
        return model.readAll()
            .then(records => res.status(200).send(records))
            .catch(err => next({ status: 404, message: `Resources not found`, caught: err }))
    },
    readOne(req, res, next) {
        return verifyId(+req.params.id)
            .then(id => model.readOne(id))
            .catch(err => next(err))
            .then(record => res.status(200).send(record))
            .catch(err => next({ status: 404, message: `Resource not found`, caught: err }))
    },
    update(req, res, next) {
        return verifyId(+req.params.id)
            .then(id => model.update(id))
            .catch(err => next(err))
            .then(record => res.status(200).send(record))
            .catch(err => next({ status: 422, message: `Unable to process update`, caught: err }))
    },
    delete(req, res, next) {
        return verifyId(+req.params.id)
            .then(id => model.delete(id))
            .catch(err => next(err))
            .then(record => res.status(200).send(record))
            .catch(err => next({ status: 400, message: `Unable to process delete`, caught: err }))
    }
}

function verifyId(id) {
    if (!id || typeof id !== `number`) {
        let error = new Error('Bad ID')
        error.status = 400
        return Promise.reject(error)
    }
    return Promise.resolve(id)
}

module.exports = controller' > controllers/$table.js