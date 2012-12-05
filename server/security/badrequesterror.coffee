BadRequestError = (message) ->
  Error.call this
  Error.captureStackTrace this, arguments.callee
  @name = 'BadRequestError'
  @message = message or null

BadRequestError::__proto__ = Error.prototype

module.exports = BadRequestError