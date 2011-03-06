// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var kbd;

function geezKeyboard() {
	var inputControls = new Array();
	$('input[type=text]').each(function(index){
		inputControls[index] = $(this).attr('id');
		/*
		$(this).focusin(function(){
			keyboardInFocus($(this));
		});
		$(this).focusout(function(){
			keyboardOutFocus($(this));
		});
		
		$(this).dblclick(function(){
			if (kbd.isVisible()) {
				keyboardOutFocus($(this));
				kbd.setVisible(false);
			}
			else {
				keyboardInFocus($(this));
			}
		});
		*/
	});
		
	$('textarea').each(function(index){
		inputControls[inputControls.length + index] = $(this).attr('id');
		/*
		$(this).focusin(function(){
			keyboardInFocus($(this));
		});
		$(this).focusout(function(){
			keyboardOutFocus($(this));
		});
		$(this).dblclick(function(){
			if (kbd.isVisible()) {
				keyboardOutFocus($(this));
				kbd.setVisible(false);
			}
			else {
				keyboardInFocus($(this));
			}
		});
		*/
	});
	
	kbd = new google.elements.keyboard.Keyboard(
		[google.elements.keyboard.LayoutCode.ETHIOPIC],
		inputControls);
		
	var bottom = contentSize() + 200;
	$('#kbd').css('bottom', bottom);
		
} 
function keyboardInFocus(inputControl){
	kbd.setVisible(true);
	var bottom = $(document).height() - inputControl.position().top - inputControl.height();
	//don't let the keyboard run off the screen on the right
	var right = $(document).width() - inputControl.position().left - inputControl.width();
	$('#kbd').css('right', right);
	$('#kbd').css('bottom', bottom);
	$('#kbd').show();
}

function keyboardOutFocus(inputControl){
	$('#kbd').hide();
	kbd.setVisible(false);
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


function revealMisale(sender, cssClass){
	var originator = $(sender);
	originator.hide();
	
	
	$('.' + cssClass).removeClass(cssClass);
	//$('[class|="' + cssClass + '"]').removeClass(cssClass);
	//originator.next().removeClass('hidden');
	//var misaleId = originator.attr('misale');
	//$('[misale|="' + misaleId + '"]').removeClass('hidden');
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
		appId  : '196575340361945', //'6962156513',
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
	  FB.Canvas.setSize({ height: frameSize() + 100 });
	});
});

function frameSize(){
        return Math.max( contentSize(), 800);
}

function contentSize(){
        return $('#page').height() + $('#footer').height() + 200;
}



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

