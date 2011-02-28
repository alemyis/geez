// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



function geezKeyboard() {
	$('input[type=text]').each(function(index){
		var kbd = new google.elements.keyboard.Keyboard(
      		[google.elements.keyboard.LayoutCode.ETHIOPIC],
      		[$(this).attr('id')]);
		kbd.setVisible(false);
	});
	
	$('textarea').each(function(index){
		var kbd = new google.elements.keyboard.Keyboard(
      		[google.elements.keyboard.LayoutCode.ETHIOPIC],
      		[$(this).attr('id')]);
		kbd.setVisible(false);
	});
	
}


function tweetThisPage(containerId){
	var tweetTagContainer = document.getElementById(containerId);
  	// Create the HTML for out text area
  	tweetTagContainer.innerHTML = '<a href="http://twitter.com/share' +
						'?url=' + document.location.href +
						'&via=GeezGames" ' +
						'class="twitter-share-button">Tweet</a>';
}


google.load("elements", "1", {packages: "keyboard"});
google.setOnLoadCallback(geezKeyboard);


function revealMisale(sender){
	var originator = $(sender);
	
	originator.hide();
	originator.next().removeClass('hidden');
	var misaleId = originator.attr('misale');
	$('[misale|="' + misaleId + '"]').removeClass('hidden');
}

function toggleFetan(){
	$.ajax({
	  url: "/fetan/toggle",
	  complete: function(){
	    window.location = window.location;
	  }
	});	
}

$(document).ready(function() {
 	tweetThisPage('socialMedia');
	
	FB.init({
		appId  : '6962156513',
		status : true, // check login status
		cookie : true, // enable cookies to allow the server to access the session
		xfbml  : true  // parse XFBML
	});

	FB.getLoginStatus(function(response) {
	  if (response.session) {
	   setLoggedInUser(response.session);
	  } else {
	    loginnow();//alert('else');
	    // no user session available, someone you dont know
	  }
	});

	FB.Canvas.setAutoResize();
});

function setLoggedInUser(session){
   $('input[fbKey|="fbuid"]').val(session.uid);
   $('img[fbKey|="avatar"]').attr('src', 'https://graph.facebook.com/' + session.uid  +  '/picture');
   var query = FB.Data.query('select name, email from user where uid={0}', session.uid);
   query.wait(function(rows) {
                $('input[fbKey|="nickname"]').val(rows[0].name);
                $('input[fbKey|="email"]').val(rows[0].email);
				// Got all what is needed. Don't prompt for detail any more
				$('#currentContactDetail').hide();
        });
}

function loginnow(){
	FB.login(function(response) {
	  if (response.session) {
	    if (response.perms) {
	      setLoggedInUser(response.session);
	     // user is logged in and granted some permissions.
	      // perms is a comma separated list of granted permissions
	    } else {
	      // user is logged in, but did not grant any permissions
	    }
	  } else {
	    // user is not logged in
	  }
	}, {perms:'email,user_birthday,read_stream,publish_stream,offline_access'});
}

