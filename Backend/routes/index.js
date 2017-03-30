var express = require('express');
var router = express.Router();
var userController = require('../controllers/requestcontrollers/usercontroller');

/* GET home page. */
router.route('/signup').post(userController.signup) ;

module.exports = router;
