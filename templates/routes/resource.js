const express = require(`express`)
const controller = (`../controllers/'$table'`)

const router = express.Router()

// READ ALL records for this table
router.get(`/`, controller.readAll)

// READ ONE record for this table
router.get(`/:id`, controller.readOne)

// CREATE ONE record for this table
router.post(`/`, controller.create)

// UPDATE ONE record for this table
router.put(`/:id`, controller.update)

// DELETE ONE record for this table
router.delete(`/:id`, controller.delete)

module.exports = router
