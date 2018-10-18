touch models/$table.js

echo 'WRITE models/'$table'.js'

echo 'const knex = require(`../db/knex`)
const model = {
    create(body) {
        return parseBody(body)
            .then(fields => {
                knex(`'$table'`)
                    .insert(fields)
                    .returning('*')
                    .then(record => record[0])
            })
    },
    readAll() {
        return knex('`$table`')
            .then(records => records)
    },
    readOne(id) {
        return knex(`'$table'`)
            .where(`id`, id)
            .then(record => record[0])
    },
    update(id, body) {
        return readOne(id)
            .then(() => parseBody(body))
            .then((fields) => {
                return knex(`'$table'`)
                    .where(`id`, id)
                    .update(fields)
                    .returning('*')
                    .then(updated => updated[0])
            })
    },
    delete(id) {
        return readOne(id)
            .then(() => {
                return knex(`'$table'`)
                    .where(`id`, id)
                    .del()
                    .returning(`*`)
                    .then(deleted => deleted[0])
            })
    }
}

function parseBody(body) {
    delete body.id
    let fields = {}

    return knex.table(`'$table'`).columnInfo()
        .then(columns => Object.keys(columns))
        .then(fieldNames => {
            for (let field in fieldNames) {
                if (body[field]) {
                    fields[field] = body[field]
                }
            }
            return fields
        })
}
module.exports = model' > models/$table.js