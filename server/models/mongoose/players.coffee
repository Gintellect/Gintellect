mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

playerSchema = new Schema {
user_id: 'ObjectId'
, name: 'String'
, mood: 'String'
}

mongoose.model 'Player', playerSchema