// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


google.load("elements", "1", {packages: "keyboard"});

function onLoad() {
	$('input[type=text]').each(function(index){
		var kbd = new google.elements.keyboard.Keyboard(
      		[google.elements.keyboard.LayoutCode.ETHIOPIC],
      		[$(this).attr('id')]);
	});
	
	$('textarea').each(function(index){
		var kbd = new google.elements.keyboard.Keyboard(
      		[google.elements.keyboard.LayoutCode.ETHIOPIC],
      		[$(this).attr('id')]);
	});
}

google.setOnLoadCallback(onLoad);



function tweetThis(containerId){
	var content = document.getElementById(containerId);
  	// Create the HTML for out text area
  	content.innerHTML = '<a href="http://twitter.com/share' +
						'?url=' + document.location.href +
						'&via=GeezGames" ' +
						'class="twitter-share-button">Tweet</a>';
}

$(document).ready(function() {
 	tweetThis('socialMedia');
});
