// Orientations.
var TOP = 0;
var BOTTOM = 1;

$(function(){
	// Init canvas
	var imageCanvas = document.getElementById("imageCanvas");
	var topTextCanvas = document.getElementById("topTextCanvas");
	var bottomTextCanvas = document.getElementById("bottomTextCanvas");
	var imageContext = imageCanvas.getContext('2d');
	var topTextContext = topTextCanvas.getContext('2d');
	var bottomTextContext = bottomTextCanvas.getContext('2d');
	var imageObj = new Image();
	
	imageObj.onload = function() {
		setCanvasDimensions(this);
		imageContext.drawImage(imageObj, 0, 0);
		drawText(bottomTextContext);
		drawText(topTextContext);
	};

	// Sets dimensions of canvases to match that of an image.
	function setCanvasDimensions(img) {
		imageContext.canvas.width = img.width;
		topTextContext.canvas.width = img.width;
		bottomTextContext.canvas.width = img.width;
		imageContext.canvas.height = img.height;
		topTextContext.canvas.height = img.height;
		bottomTextContext.canvas.height = img.height;
		$('.canvas-container').height(img.height);
		$('.canvas-container').width(img.width);
	}

	$('.template').click(function(){
		imageContext.clearRect(0, 0, imageCanvas.width, imageCanvas.height);
		imageObj.src = this.src;
	});

	$('input#content\\[top\\]').keyup(function() {
		drawText(topTextContext)
	});

	$('input#content\\[bottom\\]').keyup(function() {
		drawText(bottomTextContext)
	});

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
				y = context.canvas.height - 10; 
				orientation = BOTTOM;
			}
			context.clearRect(0, 0, context.canvas.width, context.canvas.height);
			context.font = 'bold 42pt Helvetica';
			context.textAlign = 'center';
			context.fillStyle = 'white';
			context.strokeStyle = 'black'
			context.lineWidth = 1;
			wrapText(context, text, x, y, context.canvas.width, 44, orientation);
		}
	}

  	function wrapText(context, text, x, y, maxWidth, lineHeight, orientation) {
        var words = text.split(' ');
        var line = '';
        var numLines = 0;

        for(var n = 0; n < words.length; n++) {
          var testLine = line + words[n] + ' ';
          var metrics = context.measureText(testLine);
          var testWidth = metrics.width;
          if (testWidth > maxWidth && n > 0) {
            context.fillText(line, x, y);
            context.strokeText(line, x, y);
            line = words[n] + ' ';
            if (orientation == BOTTOM) {
	            y -= lineHeight;            	
            } else {
            	y += lineHeight;  
            }
          }
          else {
            line = testLine;
          }
        }
        context.fillText(line, x, y);
        context.strokeText(line, x, y);
      }
});