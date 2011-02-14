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