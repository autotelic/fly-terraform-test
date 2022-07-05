// async-await-plugin.js
module.exports = async function (fastify, options) {
  fastify.get('/', async function (req, reply) {
    return { hello: 'jasper' }
  })
}
