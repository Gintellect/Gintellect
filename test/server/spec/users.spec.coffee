should = require 'should'

#rewire acts exactly like require.
rewire = require 'rewire'
users = rewire '../../../server/controllers/users'
mockUser = require '../mocks/users'

users.__set__("User", mockUser)

describe 'User index', ->
  it 'sets content type to json', (done) ->
    req = {}
    res = {}
    max = 11
    response = ''
    req.query = {max: max}

    res.setHeader = (a,b) ->
      a.should.equal 'Content-Type'
      b.should.equal 'application/json'
    
    res.write = (a) ->
      response = response + a

    res.end = ->
      response.should.equal('[{"test":"data"}]')
      done()

    mockUser.setNameField('david')
    sales.index(req,res)