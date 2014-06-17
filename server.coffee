express = require('express')
app = express()
bodyParser = require('body-parser')
methodOverride = require('method-override')

mongoose = require('mongoose')
mongoose.connect("mongodb://localhost/ptp")

app.use bodyParser({})
app.use methodOverride()

Bar = require('./app/models/bar')

port = process.env.PORT || 3333

router = express.Router()

router.use (req, res, next) ->
	console.log 'Something happened'
	next()

router.get "/", (req, res) ->
	res.json message: "Welcome to Paye ta Pinte's API"

router.route("/bars")
	.post (req, res) ->
		bar = new Bar(req.body)
		bar.name = req.body.name

		bar.save (err, bar) ->
			if(err)
				res.send(500, err)

			res.send(200, bar)
			# res.json message: "Bar created"

	.get (req, res) ->
		Bar.find (err, bars) ->
			if(err)
				res.send(err)

			res.json(bars)

router.route("/bars/:bar_id")
	.get (req, res) ->
		Bar.findById req.params.bar_id, (err, bar) ->
			if(err)
				res.send(err)

			res.json(bar)

app.use('/', router)

app.listen(port)
console.log 'Paye ta Pinte on port: ' + port
