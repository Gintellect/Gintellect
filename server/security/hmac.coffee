passport = require 'passport'
util = require 'util'
crypto = require 'crypto'

Strategy = (options, verify) ->
  if (typeof options == 'function')
    verify = options
    options = {}

  if not verify
    throw new Error('hmac authentication strategy requires a verify function')
  
  @_accessKeyField = options.accessKeyField or 'access-key'
  @_signatureField = options.signaturefield or 'signature'
  
  passport.Strategy.call this
  @name = 'hmac'
  @_verify = verify
  @_passReqToCallback = options.passReqToCallback
  null

# Inherit from `passport.Strategy`.
util.inherits Strategy, passport.Strategy

stringToSign = (req) ->
  parts = []
  parts.push req.method
  parts.push req.headers.toString()
  parts.join '\n'

hmac = (key, string, digest, fn) ->
  if not digest
    digest = 'binary'
  if not fn
    fn = 'sha256'
  crypto.createHmac(fn, key).update(string).digest(digest)

Strategy::authenticate = (req, options) ->
  console.log 'in hmac authenticate'

  verified = (err, user, info) =>
    if err
      return @error err
    else if not user
      return @fail info

    #TODO: get secret from the user id
    verificationSecret = 'not very secret'
    verificationString = stringToSign req
    verificationSignature = hmac accessKey, verificationString, 'base64'
    
    console.log 'verif string: ' + verificationString
    console.log 'req sig: ' + reqSignature
    console.log 'verif sig: ' + verificationSignature
   
    if reqSignature != verificationSignature
      @fail {message: 'Signature Verification Failure'}
    else
      @success user, info

  options = options or {}
  accessKey = req.headers[@_accessKeyField]
  reqSignature = req.headers[@_signatureField]
  
  console.log 'req accessKey: ' + accessKey
  console.log 'req signature: ' + reqSignature

  if not accessKey or not reqSignature
    return @fail({message:'Missing credentials'})
 
  if @_passReqToCallback
    @_verify req, accessKey, verified
  else
    @_verify accessKey, verified

# Expose `Strategy`.
exports.Strategy = Strategy