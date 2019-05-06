var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

var childProcess = require('child_process');
var githubUsername = 'gayansandaruwan'


router.post("/webhooks/github", function (req, res) {
    var sender = req.body.sender;
    var branch = req.body.ref;
    console.log(sender);
    console.log(branch);
    // if(branch.indexOf('master') > -1 && sender.login === githubUsername){
        deploy(res);
    // }
})

function deploy(res){
    childProcess.exec('cd /home/gayankavirathne/PDRMax/node-dep-auto-webhook/ && ./clone_or_update.sh', function(err, stdout, stderr){
        if (err) {
         console.error(err);
         return res.send(500);
        }
        res.send(200);
      });
}

module.exports = router;
