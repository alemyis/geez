// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var kbd;

function geezKeyboard() {
	var inputControls = new Array();
	$('input[type=text]').each(function(index){
		inputControls[index] = $(this).attr('id');
		$(this).focusin(function(){
			keyboardInFocus($(this));
		});
		$(this).focusout(function(){
			keyboardOutFocus($(this));
		});
	});
		
	$('textarea').each(function(index){
		inputControls[inputControls.length + index] = $(this).attr('id');
		$(this).focusin(function(){
			keyboardInFocus($(this));
		});
		$(this).focusout(function(){
			keyboardOutFocus($(this));
		});
	});

 	kbd = new google.elements.keyboard.Keyboard(
		[google.elements.keyboard.LayoutCode.ETHIOPIC],
		inputControls);
		
	kbd.setVisible(false);
} 
function keyboardInFocus(inputControl){
	kbd.setVisible(true);
	$('#kbd').attr('style', '');
	$('#kbd').attr('style', 'visibility: visible; position: absolute;');
	$('#kbd').css('top', inputControl.position().top + inputControl.height() + 10);
	$('#kbd').css('left', inputControl.position().left);
}

function keyboardOutFocus(inputControl){
	kbd.setVisible(false);
	$('#kbd').attr('style', '');
	$('#kbd').attr('style', 'position: absolute;');
}
function ageezKeyboard() {
	var inputControls = new Array();
	$('input[type=text]').each(function(index){
		inputControls[index] = $(this).attr('id');
		
		// put the virtual keyboard right bellow the input box
		$(this).focusin(function(){
			kbd.setVisible(true);
			$('#kbd').attr('style', '');
			$('#kbd').attr('style', 'visibility: visible; position: absolute;');
			$('#kbd').css('top', $(this).position().top + $(this).height() + 15);
			$('#kbd').css('left', $(this).position().left);
		});
		$(this).focusout(function(){
			kbd.setVisible(false);
			$('#kbd').attr('style', '');
		});
	});
	
	
	$('textarea').each(function(index){
		inputControls[inputControls.length + index] = $(this).attr('id');

		// put the virtual keyboard right bellow the input box
		$(this).focusin(function(){
			kbd.setVisible(true);
			$('#kbd').attr('style', '');
			$('#kbd').attr('style', 'visibility: visible; position: absolute;');
			$('#kbd').css('top', $(this).position().top + $(this).height() + 15);
			$('#kbd').css('left', $(this).position().left);
		});
		$(this).focusout(function(){
			kbd.setVisible(false);
			$('#kbd').attr('style', '');
		});
	});
	
	
	kbd = new google.elements.keyboard.Keyboard(
      		[google.elements.keyboard.LayoutCode.ETHIOPIC],
			inputControls);
	
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
 	//tweetThisPage('socialMedia');
	
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
	  	//Don't force login. Let user trigger this action. 
	    //loginnow();
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

