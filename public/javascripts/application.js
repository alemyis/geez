var kbd;

// We may want to position the keyboard in other places besides the default
// bottom right. But this doesn't seem possible at the moment. Related links:
// http://tinyurl.com/5rolfzu http://tinyurl.com/685mzgy
function geezKeyboard() {
	var inputControls = new Array();
	$('input[type=text]').each(function(index){
		inputControls[index] = $(this).attr('id');
	});
		
	$('textarea').each(function(index){
		inputControls[inputControls.length + index] = $(this).attr('id');
	});
	
	kbd = new google.elements.keyboard.Keyboard(
		[google.elements.keyboard.LayoutCode.ETHIOPIC],
		inputControls);

  	setTimeout('keyBoardHelp()', 3000);
	
	if(!geezFontDetect()){
		inLineAlert("We think you may be missing a compatable font. You may download one from <a href='ftp://ftp.ethiopic.org/pub/fonts/TrueType/gfzemenu.ttf'>here</a>.");
	}
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
}

function toggleFetan(){
	$.ajax({
	  url: "/fetan/toggle",
	  complete: function(){
	    window.location.reload();
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

// Font detection technique inspired by - http://www.lalit.org/lab/javascript-css-font-detect
function geezFontDetect(){
	//expect to have 'CheCheCheCheCheCheChe' to be wider than 'mmmmmmm'
	var h = document.getElementsByTagName("BODY")[0];
	var d = document.createElement("DIV");
	var s = document.createElement("SPAN");
	d.appendChild(s);
	//d.style.display    = "none";
	d.style.fontFamily = "sans";			//font for the parent element DIV.
	s.style.fontFamily = "sans";			//serif font used as a comparator.
	s.style.fontSize   = "72px";			//we test using 72px font size, we may use any size. I guess larger the better.
	s.innerHTML        = "mmmmmmm";		//we use m or w because these two characters take up the maximum width. And we use a L so that the same matching fonts can get separated
	h.appendChild(d);
	var defaultWidth   = s.offsetWidth;		//now we have the defaultWidth
	h.removeChild(d);
	
	s.innerHTML			= "&#x1328;&#x1328;&#x1328;&#x1328;&#x1328;&#x1328;&#x1328;"; //unicode string for Che's
	h.appendChild(d);
	var geezWidth = s.offsetWidth;
	h.removeChild(d);
	return geezWidth > defaultWidth;
}

function inLineAlert(msg){
	$('#inlineAlert')
	.addClass('error_explanation')
	.html(msg)
	.show();
}
