// Orientations.
var TOP = 0;
var BOTTOM = 1;
var imageCanvas, topTextCanvas, bottomTextCanvas, imageContext, topTextContext, bottomTextContext;
var imageObj = new Image();

// Add callback option to popover.
var tmp = $.fn.popover.Constructor.prototype.show;
$.fn.popover.Constructor.prototype.show = function () {
  tmp.call(this);
  if (this.options.callback) {
    this.options.callback();
  }
}

function init() {
	// Init canvases.
	imageCanvas = document.getElementById("imageCanvas");
	topTextCanvas = document.getElementById("topTextCanvas");
	bottomTextCanvas = document.getElementById("bottomTextCanvas");
	
	// Just check for one canvas, because either they're all on the page or they're not.
	if (imageCanvas != null) {
		imageContext = imageCanvas.getContext('2d');
		topTextContext = topTextCanvas.getContext('2d');
		bottomTextContext = bottomTextCanvas.getContext('2d');
	}

	// imageObj.crossOrigin = '';
	console.log($(imageObj));

	$('.template').click(function(){
		$('#template-name').text($(this).attr('title'));

		// CORS workaround.
		uncachedSrc = this.src + "?_";
		
		if (imageObj.src != uncachedSrc) {
			imageContext.clearRect(0, 0, imageCanvas.width, imageCanvas.height);
			imageObj.src = uncachedSrc;	
			if ($("#user-uploaded-img").src.length > 0) {
				resetFileInput();				
			}
		}
	});

	$('input#content\\[top\\]').keyup(function() {
		drawText(topTextContext)
		// Send over each layer with the POST request.
		var base64Image = topTextCanvas.toDataURL("image/png");
		$('#images_top').val(base64Image.substr(base64Image.indexOf(',')));
	});

	$('input#content\\[bottom\\]').keyup(function() {
		drawText(bottomTextContext)
		// Send over each layer with the POST request.
		var base64Image = bottomTextCanvas.toDataURL("image/png");
		$('#images_bottom').val(base64Image.substr(base64Image.indexOf(',')));
	});

	// Auto-hide success notices since they don't require any action by the user.
	$('.alert-success').delay(4000).fadeOut(400, function(){
		$(this).remove();
	});

	$('.vote-button').hide();
	$('.meme').hover(function() {
		$(this).find('.vote-button').show();
	}, function() {
		$(this).find('.vote-button').hide();
	});

	$('.vote-button, .vote-button-show').click(function(){
		// Submit form.
		memeContainer = $(this).parent().parent();
		memeContainer.find("#vote_value").val(this.value);
		form = memeContainer.find("#vote_form");
		var button = $(this);
	    $.ajax({
	       type: "POST",
	       url: $(form).attr('action'),
	       data: $(form).serialize(), // serializes the form's elements.
	       success: function(data) { 
		       	if (data.status == "success") {
		       		memeContainer.find("#vote-count").html("+" + data.vote_count);
       		     	memeContainer.find(".active").removeClass("active");
			     	button.addClass("active"); 
		       	} else if (data.status == "not_signed_in") {
		       		flashAlert('You must be <a href="/users/sign_in"><b>signed in</b></a> to vote!');
		       	}
	       	}
     	});
	});

	if($('.group-link').length > 0){
		$('.group-visibility small').hover(function(){
			$(this).css({'color': '#47a447'});
		}, function(){
			$(this).css({'color': '#999999'})
		}).css({'cursor': 'pointer'});

		$('.group-visibility small').popover({
			title: "Share this group",
			content: "<input type='text' value='" + window.location + "' readonly/>",
			html: true,
			container: '.group-visibility',
			callback: function() {
				$('.popover input').get(0).select();
				$('.popover input').click(function(){
					$(this).get(0).select();						
				});
			}
		});

		$('.group-visibility small').click(function(){
			$(this).popover();
		});
	}

	$('#user-uploaded-img').bind('load', function() {
	    imageObj.src = this.src;
	});

	$("#user-template").change(function(){
		var filename = $(this).val();
		if (filename) {
			var startIndex = (filename.indexOf('\\') >= 0 ? filename.lastIndexOf('\\') : filename.lastIndexOf('/'));
			var filename = filename.substring(startIndex);
			if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
				filename = filename.substring(1);
			}
			$("#filename").text(filename);
			readImage(this);
		}

	});

	$("#upload-template-btn").click(function(){
		$("#user-template").click();
	});

	$('.alert .close').on('click', function (e) {
		$(this).parent().hide();
	});
	
}

// For turbolinks.
$(window).bind('page:change', init);

$(document).ready(init);

imageObj.onload = function() {
//	this.setAttribute('crossOrigin', 'anonymous');
	if (checkImageDimensions(this) == false) {
		return;
	}
	setCanvasDimensions(this);
	imageContext.drawImage(imageObj, 0, 0, imageObj.width, imageObj.height);
	drawText(bottomTextContext);
	drawText(topTextContext);
	var base64Image = imageCanvas.toDataURL("image/png");
	$('#images_bg').val(base64Image.substr(base64Image.indexOf(',')));
};


function readImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
        	$("#user-uploaded-img").attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}

function checkImageDimensions(img) {
	if (img.width > 700 && img.height > 700) {
		flashAlert('Your image may be no larger than 700 x 700 pixels! Yours is ' + img.width + ' x ' + img.height + '.');
		resetFileInput();
		return false;
	} else if(img.width > 700) {
		flashAlert('The width of your image (' + img.width + 'px) exceeds the maxiumum allowed width of 700px!');
		resetFileInput();
		return false;
	} else if (img.height > 700) {
		flashAlert('The height of your image (' + img.height + 'px) exceeds the maxiumum allowed height of 700px!');
		resetFileInput();
		return false;
	}

	return true;
}

function resetFileInput() {
	$('#user-template').wrap('<form>').closest('form').get(0).reset();
	$('#user-template').unwrap();
	$('#filename').text("");
}

// Sets dimensions of canvases to match that of an image.
function setCanvasDimensions(img) {

	console.log(img.width);
	console.log(img.height);
	imageContext.canvas.width = img.width;
	topTextContext.canvas.width = img.width;
	bottomTextContext.canvas.width = img.width;
	imageContext.canvas.height = img.height;
	topTextContext.canvas.height = img.height;
	bottomTextContext.canvas.height = img.height;
	$('.canvas-container').height(img.height);
	$('.canvas-container').width(img.width);
}

function drawText(context) {
	if (imageObj.src) {
		var x, y, text, orientation;
		if (context == topTextContext) {
			text = $('input#content\\[top\\]').val().toUpperCase();
			x = context.canvas.width / 2;
			y = 50;
			orientation = TOP;
		} else if (context == bottomTextContext) {
			text = $('input#content\\[bottom\\]').val().toUpperCase();
			x = context.canvas.width / 2;
			y = context.canvas.height - 4; 
			orientation = BOTTOM;
		}
		context.clearRect(0, 0, context.canvas.width, context.canvas.height);
		context.font = 'bold 42pt Impact, Helvetica';
		context.textAlign = 'center';
		context.fillStyle = 'white';
		context.strokeStyle = 'black'
		context.lineWidth = 2;
		var lineHeight = 50;
		if (navigator.platform == "Linux") {
			// Linux uses closer spacing.
			lineHeight = 52;
		}
		wrapText(context, text, x, y, context.canvas.width, lineHeight, orientation);
	}
}

function measureNumLines(context, words, maxWidth, lineHeight) {
	var numLines = 1;

	// Count the number of lines and adjust the y coordinate for bottom text.
	// This is so we get text like 
	// ---------              ---------
	// |       |              |       |
	// | this  |  instead of  |wrapped|
	// |  is   |              |  is   |
	// |wrapped|              | this  |
	// ---------              ---------

	var tempLine = '';
	for(var n = 0; n < words.length; n++) {
	var testLine = tempLine + words[n] + ' ';
	var metrics = context.measureText(testLine);
	var testWidth = metrics.width;
		if (testWidth > maxWidth && n > 0) {
		    tempLine = words[n] + ' ';
		    numLines++;
		} else {
			tempLine = testLine;
		}
	}

	return numLines;
}

function flashAlert(msg) {
	$('#flash_js').html(msg);
	$('.js-alert').removeClass('alert-success');
	$('.js-alert').addClass('alert-danger');
	$('.js-alert').show();
}

function wrapText(context, text, x, y, maxWidth, lineHeight, orientation) {
	var words = text.split(' ');
	var line = '';

	var numLines = measureNumLines(context, words, maxWidth, lineHeight);

	// Set the lineheight and fontsize based on the number of lines used.
	if (numLines >= 5) {
		context.font = 'bold 28pt Impact, Helvetica';
		lineHeight -= 16;
		if (orientation == TOP) {
			y -= 14;
		}
		// Remeasure.
		numLines = measureNumLines(context, words, maxWidth, lineHeight);
	} else if (numLines >= 4) {
		context.font = 'bold 32pt Impact, Helvetica';
		lineHeight -= 12;
		if (orientation == TOP) {
			y -= 10;
		}
		// Remeasure.
		numLines = measureNumLines(context, words, maxWidth, lineHeight);
	} else if (numLines >= 3) {
		context.font = 'bold 36pt Impact, Helvetica';
		lineHeight -= 6;
		if (orientation == TOP) {
			y -= 6;
		}
		// Remeasure.
		numLines = measureNumLines(context, words, maxWidth, lineHeight);
	}


	if (orientation == BOTTOM) {
		// Start higher if more than one line is required.
		for(var i = 1; i < numLines; ++i) {
			y -= lineHeight;
		}
	}
	

	for(var n = 0; n < words.length; n++) {
	  var testLine = line + words[n] + ' ';
	  var metrics = context.measureText(testLine);
	  var testWidth = metrics.width;
	  if (testWidth > maxWidth && n > 0) {
	    context.fillText(line, x, y);
	    context.strokeText(line, x, y);
	    line = words[n] + ' ';
	    y += lineHeight;  
	  }
	  else {
	    line = testLine;
	  }
	}
	context.fillText(line, x, y);
	context.strokeText(line, x, y);
}