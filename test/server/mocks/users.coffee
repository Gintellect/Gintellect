should = require 'should'

nameField = ''
expectedPrev = 10000000
max = 0

exports.setNameField = (name) ->
  nameField = name

exports.setPrev = (expectedPrev) ->
  prev = expectedPrev

exports.setMax = (expectedMax) ->
  max = expectedMax

exports.find = (a) ->
  #a should be undefined
  should.not.exist(a)
  lt: (name, number) ->
    #assert that name == transaction_id
    name.should.equal idField
    number.should.equal expectedPrev
    this
  sort: (obj) ->
    obj.should.have.property idField
    obj[idField].should.equal 'desc'
    this
  limit: (number) ->
    number.should.equal max
    this
  stream: ->
    on: (eventName, callback) ->
      if eventName == 'data'
        callback {test: 'data'}
      if eventName == 'close'
        callback()