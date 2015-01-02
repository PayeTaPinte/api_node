express = require('express')
passport = require('passport')
app = express()
bodyParser = require('body-parser')
methodOverride = require('method-override')
flash = require('connect-flash')
cookieParser = require('cookie-parser')
session = require('express-session')
mongoose = require('mongoose')
path = require('path')
router = require('./app/auth')

allowCrossDomain = (req, res, next) -> 
	res.header('Access-Control-Allow-Credentials', true)
	res.header('Access-Control-Allow-Origin', 'http://ptp01:8888') #set right domain for client
	res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
	res.header('Access-Control-Allow-Headers', 'X-Custom-Header, Content-Type, Authorization, Content-Length, X-Requested-With')

	if 'OPTIONS' == req.method
		res.send(200)
	else
		next()
		
	console.log "Session: ", req.session

port = process.env.PORT || 3333

mongoose.connect("mongodb://localhost/ptp")

require('./config/passport')
app.set 'view engine', 'jade'

app.use allowCrossDomain
app.use flash()
app.use bodyParser({})

app.use methodOverride('_method')
app.use cookieParser()

app.use session (
	secret: 'hellolesboyz'
	proxy: true
	unset: 'destroy'
)

app.use passport.initialize()
app.use passport.session()

app.use '/', require('./app/routes')

# expressJwt = require('express-jwt')
# jwt = require('jsonwebtoken')
app.use '/api', require('./app/api_routes')
# , expressJwt({secret: 'hello-api'})

app.use '/auth', require('./app/auth')

app.use '/', express.static(path.join(__dirname, "public"))

# app.use express.json()
# app.use express.urlencoded()

app.listen(port)
console.log 'Paye ta Pinte on port: ' + port
