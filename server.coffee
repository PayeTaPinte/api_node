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

port = process.env.PORT || 3333

mongoose.connect("mongodb://localhost/ptp")

require('./config/passport')
app.set 'view engine', 'jade'

app.use flash()
app.use bodyParser({})

app.use methodOverride('_method')
app.use cookieParser()

app.use session (
	secret: 'hellolesboyz'
	proxy: true
)

app.use passport.initialize()
app.use passport.session()

app.use '/', require('./app/routes')
app.use '/api', require('./app/api_routes')
app.use '/auth', require('./app/auth')
app.use '/', express.static(path.join(__dirname, "public"))

app.listen(port)
console.log 'Paye ta Pinte on port: ' + port
