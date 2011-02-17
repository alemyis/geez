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
});
