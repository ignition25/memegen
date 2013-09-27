$(function(){
	// Init canvas
	var imageCanvas = document.getElementById("imageCanvas");
	var textCanvas = document.getElementById("textCanvas");
	var imageContext = imageCanvas.getContext('2d');
	var textContext = textCanvas.getContext('2d');
	var imageObj = new Image();
	
	imageObj.onload = function() {
		imageContext.canvas.width = this.width;
		textContext.canvas.width = this.width;
		imageContext.canvas.height = this.height;
		textContext.canvas.height = this.height;
		$('.canvas-container').height(this.height);
		$('.canvas-container').width(this.width);
		imageContext.drawImage(imageObj, 0, 0);
		refreshTextCanvas();
	};

	$('.template').click(function(){
		imageContext.clearRect(0, 0, imageCanvas.width, imageCanvas.height);
		imageObj.src = this.src;
	});

	$('input#content\\[top\\]').keyup(function() {
		var text = this.value.toUpperCase();
		drawTopText(text);
	});


	function refreshTextCanvas() {
		var text = $('input#content\\[top\\]').val().toUpperCase();
		drawTopText(text);
	}

	function drawTopText(text) {
		if (imageObj.src) {
			var x = textCanvas.width / 2;
			var y = 45;
			textContext.clearRect(0, 0, textCanvas.width, textCanvas.height);
			textContext.font = 'bold 32pt Helvetica';
			textContext.textAlign = 'center';
			textContext.fillStyle = 'white';
			textContext.strokeStyle = 'black'
			textContext.lineWidth = 1;
			wrapText(textContext, text, x, y, textCanvas.width, 38);
		}
	}

  	function wrapText(context, text, x, y, maxWidth, lineHeight) {
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
            y += lineHeight;
          }
          else {
            line = testLine;
          }
        }
        context.fillText(line, x, y);
        context.strokeText(line, x, y);
      }
});