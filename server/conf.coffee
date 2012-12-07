
port = process.env.PORT ? process.argv.splice(2)[0] ? 8080

module.exports =
  db :
    host: process.env['DOTCLOUD_DB_MONGODB_HOST'] or 'localhost'
    port: process.env['DOTCLOUD_DB_MONGODB_PORT'] or '27017'
    username: process.env['GINTELLECT_WWW_DB_LOGIN'] or 'user'
    password: process.env['GINTELLECT_WWW_DB_PASSWORD'] or 'pass'
  www:
    port: port
  security:
    FACEBOOK_APP_ID: process.env['GINTELLECT_WWW_FACEBOOK_APP_ID']
    FACEBOOK_APP_SECRET:  process.env["GINTELLECT_WWW_FACEBOOK_APP_SECRET"]
    DOMAIN_URI: process.env["GINTELLECT_WWW_DOMAIN_URI"] ?
    "http://www.gintellect.com"