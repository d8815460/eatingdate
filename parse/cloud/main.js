// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

  
//傳送簡訊
var twilio = require("twilio");
twilio.initialize("ACf36e14fd8bfff8b6ee9188b21f44464f", "22cd5de0c7afaed812ce28ea63b9f7bc");
  
Parse.Cloud.define("inviteWithTwilio", function (request, response) {
    twilio.sendSMS({
        From: "+19803324002",
        To: request.params.number,
        Body: "感謝您驗證手機號碼，驗證碼為 " + request.params.phoneCode
    }, {
        success: function (httpResponse) {
            console.log(httpResponse);
            response.success("SMS sent!");
        },
        error: function (httpResponse) {
            console.error(httpResponse);
            response.error(httpResponse);
        }
    });
});
 
 
/*
Parse.Cloud.job("userMigration", function(request, status) {
  // Set up to modify user data
  Parse.Cloud.useMasterKey();
  var query = new Parse.Query(Parse.PostDate);
  var startTime.setTime = new Date(dateTime);
  var startMsec = startTime.getMilliseconds();
  var elapsed = (starTime.getTime() - startMsec)/1000;
  //約會開始時間>=7200秒(2小時)
  if(elapsed >= 60){
      //query.notEqualTo('isFromUserJudge', true);
      //query.notEqualTo('isToUserJudge', true);
      //query.notEqualTo('isPushJudge', true);
      Parse.Push.send({
          channels: [ "user_HAlkS0Hs51" ],
          data: {
            alert: "別忘了互相給予好評價！立馬去評價",
            "p": "a",
            "t": "unrating",
            badge: "Increment",
            "fu": "v6xJc3LcRZ",
            "tu": "v6xJc3LcRZ",
            "po": "aMT7wLY1E8", 
            "com.eatingDate.CUSTOM_BROADCAST": "action"
          }
          //push_time: tomorrowDate
 
        }, {
          success: function() {
            // Push was successful
            var order = new Parse.Object('Order');
            order.set('name', 'name');
            order.set('type', 'unrating');
 
          
            // Create new order
            return order.save().then(null, function(error) {
              // This would be a good place to replenish the quantity we've removed.
              // We've ommited this step in this app.
              console.log('Creating order object failed. Error: ' + error);
              return Parse.Promise.error('An error has occurred. Your credit card was not charged.2');
            });
            status.success("Migration completed successfully.");
             
          },
          error: function(error) {
            // Handle error
            status.error("Uh oh, something went wrong.");
          }
        });  
  }
   
 
});
 
*/
/*commercial:每日約會數量for ios*/
Parse.Cloud.job("everyday", function(request, status) {
  // Set up to modify user data
  Parse.Cloud.useMasterKey();
  //var counter = 0;
  var query = new Parse.Query(Parse.Installation);
  query.equalTo('channel', 'user_HAlkS0Hs51');
  Parse.Push.send({
      where: query,
      data: {
        alert: "今日達成的約會數量共118件,你還在等什麼?立即報名約會!",
        "p": "a",
        "t": "commercial",
        badge: "Increment",
        //"fu": "v6xJc3LcRZ",
        //"tu": "v6xJc3LcRZ",
        //"po": "aMT7wLY1E8", 
        "com.eatingDate.CUSTOM_BROADCAST": "action"
      }
    }, {
      success: function() {
        // Push was successful
        status.success("everyday completed successfully.");
      },
      error: function(error) {
        // Handle error
        status.error("Uh oh, something went wrong.");
      }
    });
 
});