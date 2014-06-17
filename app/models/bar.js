mongoose = require('mongoose')
Schema = mongoose.Schema

BarSchema = new Schema({name: String})

module.exports = mongoose.model('Bar', BarSchema)