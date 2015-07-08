
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

Parse.Cloud.job("userMigration", function(request, status) {
  // Set up to modify user data
  Parse.Cloud.useMasterKey();
  var counter = 0;
  Parse.Push.send({
	  channels: [ "user_I6eePXy4oa" ],
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
	}, {
	  success: function() {
		// Push was successful
		status.success("Migration completed successfully.");
	  },
	  error: function(error) {
		// Handle error
		status.error("Uh oh, something went wrong.");
	  }
	});

  // Query for all users
  /*
  var query = new Parse.Query(Parse.User);
  query.each(function(user) {
      // Update to plan value passed in
      user.set("plan", request.params.plan);
      if (counter % 100 === 0) {
        // Set the  job's progress status
        status.message(counter + " users processed.");
      }
      counter += 1;
      return user.save();
  }).then(function() {
    // Set the job's success status
    status.success("Migration completed successfully.");
  }, function(error) {
    // Set the job's error status
    status.error("Uh oh, something went wrong.");
	
  });
  */
});