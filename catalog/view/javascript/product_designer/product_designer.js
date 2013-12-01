function product_designer(id, viewOnly){
	var THIS = this;
	if(id == null || id == '')
	{	
		console.log('error roi');
		return;
	}
	this._canvas = new fabric.Canvas(id);
	if(typeof(viewOnly) == 'undefined' || viewOnly != true){
		this._canvas.on('mouse:up', function(o) {
			if(o.target !== undefined){	
				
			} 
			else{
				$('#pcpb_edit_text,#pcpb_edit_image,#pcpb_edit_background').hide();
			}
		});
	}
	
	var flag1 = true;
	
	fabric.Canvas.prototype.getAbsoluteCoords = function(object) {
	  return {
		left: object.left + this._offset.left,
		top: object.top + this._offset.top
	  };
	}

	
	function positionBtnRotate(obj) {
		$('#icon-rotate').css('display','block');
		var absCoords = canvas.getAbsoluteCoords(obj);
		
		posLeft1 = (absCoords.left + 55) + 'px';
		posTop1 = (absCoords.top - 40) + 'px';

	    $('#icon-rotate').css({ position: "absolute", left: posLeft1, top: posTop1 });
	}
	
	function positionBtnDelete(obj) {
		$('#icon-delete').css('display','block');
		var absCoords = canvas.getAbsoluteCoords(obj);
		
		posLeft2 = (absCoords.left - 75) + 'px';
		posTop2 = (absCoords.top - 40) + 'px';

	    $('#icon-delete').css({ position: "absolute", left: posLeft2, top: posTop2 });
	}
	
	this.rotateActiveObject = function(){
		var c = this._canvas;
		var obj = c.getActiveObject(); 
		obj.set('angle', obj.get('angle') + 45);
		c.renderAll();
	};
	
	this.saveTextSetting = function(){
		var c = this._canvas;
		if(c.getActiveObject() == null){
			var textObject = c.item(0); 
		} else {
			var textObject = c.getActiveObject();
		}
		if(c.getObjects().length > 0){
			if(textObject.type != 'text')
				return;
			textObject.setText($('#pd-text-content').val());
			var fonts = $('#pd-text-font').text();
			var re = /((\s*\S+)*)\s*/;
			fonts = fonts.replace(re, "$1");
			textObject.setFontFamily(fonts);
			textObject.setFontSize(parseInt($('#pd-text-fontsize').val()));
			var hex = $('#colorpicker_picker').val();
			if(checkHex(hex))
				textObject.setFill(hex);	
				
			c.renderAll();
		}
	};
	this.flipHorizontalImage = function(){
		var c = this._canvas;
		var imgObject = c.getActiveObject();
		if(imgObject.type != 'image')
			return;
		var newFlipX = !imgObject.getFlipX();
		imgObject.setFlipX(newFlipX);
		c.renderAll();
	};
	this.flipVerticalImage = function(){
		var c = this._canvas;
		var imgObject = c.getActiveObject();
		if(imgObject.type != 'image')
			return;
		var newFlipY = !imgObject.getFlipY();
		imgObject.setFlipY(newFlipY);
		c.renderAll();
	};
	this.addImage = function(url,width_img,height_img){	
		alert('sdjfhsjdh');
		var c = this._canvas;
		fabric.Image.fromURL(url, function(img) {
			img.set({
				top:img.height/2,
				left:img.width/2,
				cornerSize: 5,
				borderColor: 'red',
				cornerColor: 'green'
			})
			
			c.add(img);
			c.setActiveObject(img);
			
		});
	};
	
	this.shadowText = function(){
		var c = this._canvas;
		var textObject = c.getActiveObject();
		if(textObject.type != 'text')
			return;
        if($('#pd-text-shadow').val() == 'Remove Shadow'){
            textObject.set({shadow: $('#pd-shadow-color').val() + ' ' + $('#pd-horizontal-offset').val() + ' ' + $('#pd-vertical-offset').val() + ' ' + $('#pd-blur-size').val() });
        }
        else if($('#pd-text-shadow').val() == 'Shadow'){
            textObject.set({shadow: $('#pd-shadow-color').val() + ' 0 0 0' });
        }
		c.renderAll();
	};


    this.borderText = function(){
		var c = this._canvas;
        var textObject = c.getActiveObject();
        if(textObject.type != 'text')
            return;
        if($('#pd-text-border').val() == 'Remove Border'){
            textObject.set({ stroke: $('#pd-border-color').val(), strokeWidth: $('#pd-stroke-width').val() });
        }
        else if($('#pd-text-border').val() == 'Border'){
            textObject.set({ stroke: 'none', strokeWidth: 0 });
        }

        c.renderAll();
    };
	var canvas = new fabric.Canvas('pd_canvas');
	
	this.curveText = function(){
		var c = this._canvas;
		var props = {};
		var obj = c.getActiveObject();
        if(obj){
            if(/curvedText/.test(obj.type)) {
                default_text = obj.getText();
                props = obj.toObject();
                delete props['type'];
                var textSample = new fabric.Text(default_text, props);
            }else if(/text/.test(obj.type)) {
                default_text = obj.getText();
                props = obj.toObject();
                delete props['type'];
                props['textAlign'] = 'center';
                props['radius'] = 40;
                props['spacing'] = 20;
                var textSample = new fabric.CurvedText(default_text, props);
            }
            c.remove(obj);
            c.add(textSample).renderAll();
            c.setActiveObject(textSample);
			c.getActiveObject().sendBackwards();
        }
		
    };
	
	this.curvedTextRadius = function(){
	    var c = this._canvas;
    	var obj = c.getActiveObject();
    	if(obj){
            obj.set('radius', 40 + $('#pd-radius').val()); 
    	}
    	c.renderAll();
	};
    
    this.curvedTextSpacing = function(){
	    var c = this._canvas;
    	var obj = c.getActiveObject();
    	if(obj){
            obj.set('spacing', 20 + $('#pd-spacing').val()); 
    	}
    	c.renderAll();
	};
    
	
	//set active object
	this.setActive = function(index){
		var c = this._canvas;
		c.setActiveObject(c.item(index));
	};
	
	this.setCurrentImagePath = function(path, width, height){
		var c = this._canvas;
		var oldImg = c.getActiveObject();
		if(oldImg.type != 'image')
			return;
		if(typeof(width) == 'undefined')
			var width = oldImg.getWidth();
		if(typeof(height) == 'undefined')
			var height = oldImg.getHeight();
		width=parseInt(width);
		height=parseInt(height);
		var top = oldImg.getTop();
		var left = oldImg.getLeft();

		var ratioWidth = width/c.width;
		var ratioHeight = height/c.height;
		var maxRatio = Math.max(ratioWidth, ratioHeight);
		if(maxRatio >= 1){
			var ratio = width/height;
			if(ratioWidth > ratioHeight){
				width = c.width*80/100;
				height = width/ratio;

			}
			else{
				height = c.height*80/100;
				width = height*ratio;
			}
			top = height/2+c.height*10/100;
			left = width/2+c.width*10/100;
		}

		fabric.Image.fromURL(path, function(img) {
			img.set({
				top:top,
				left:left,
				width: width,
				height: height,
				cornerSize: 5,
				borderColor: 'red',
				cornerColor: 'green'
			})
			c.remove(oldImg);
			c.add(img);
			c.setActiveObject(img);
			$('ul.bxslider li').remove();
			$('ul.bxslider').find('li.item_'+ c.getObjects().indexOf(c.getActiveObject())).children().css('border','0');
		var index = c.getObjects().length - 1;
		c.forEachObject(function(obj){
			if(obj.type == 'text' || obj.type == 'curvedText') {
				$('ul.bxslider').append('<li class="item_'+ index +'"><div style="width:100%;height:auto;text-align:center;display:table;"><span onclick="pcpb.setActive('+ index +')" style="display: table-cell;vertical-align: middle;cursor: pointer;font-family:'+ obj.getFontFamily() +';font-size:18px;color:'+ obj.getFill() +';">'+ obj.text +'</span></div></li>');
				index -= 1;
			}
			if(obj.type == 'image') {
				if(obj.getSrc() != c.backgroundImage.src) {
					$('ul.bxslider').append('<li class="item_'+ index +'"><img onclick="pcpb.setActive('+ index +')" style="cursor: pointer;width:auto;max-width:88px;height:auto;max-height:88px;padding:5px;" src="'+ obj.getSrc() +'" /></li>');					
				}
				index -= 1;
			}
		});
			slider.reloadSlider();
			$('ul.bxslider').find('li.item_'+ c.getObjects().indexOf(c.getActiveObject())).children().css('border','1px solid #38B0E3');
			
		});
	};
	this.setWidth = function(width){
		this._canvas.setWidth(width);
	};
	this.setHeight = function(height){
		this._canvas.setHeight(height);
	};
	this.setBackgroundImage = function(url, width, height){
		var c = this._canvas;
		
		var text = new fabric.Text($('#pd-text-content').val(), {
				top: 0,
				left: 0,
				fontSize: 40,
				cornerSize: 5,
				borderColor: 'red',
				cornerColor: 'green',
			});
			text.id = "canvas-text";
			c.add(text);
			c.setActiveObject(text);
			c.centerObject(c.getActiveObject());
			$('#pd-text-fontsize').val(40);
		
		fabric.Image.fromURL(url, function(img) {
			img.set({
				width: width,
				height: height,
				selectable: false,
				selection: false,
				hasBorders: false,
				hasControls: false,
				cornerSize: 5,
				borderColor: 'red',
				cornerColor: 'green'
			})
			img.id = "canvas-background";
			c.add(img);
			c.setActiveObject(img);
			//c.getActiveObject().lockMovementX = c.getActiveObject().lockMovementY = true;
			c.centerObject(c.getActiveObject());
		});
		c.on({
			'object:moving': onChange,
			'object:scaling': onChange,
			'object:rotating': onChange,
		  });

		  function onChange(options) {
			options.target.setCoords();
			c.forEachObject(function(obj) {
				if (obj === options.target) return;
				obj.setOpacity(options.target.intersectsWithObject(obj) ? 0.7 : 1);
			});
		  }
		
	};
	this.loadFromJSON = function(json){
		this._canvas.loadFromJSON(json);
	};
	this.saveToImage = function(){
		var c = this._canvas;
		var o = c.getActiveObject();
		if(o != null){
			o.setActive(false);
			c.renderAll();
		}
		return this._canvas.toDataURL();
	};
	
	
}

function rgb2hex(rgb) {
	if (  rgb.search("rgb") == -1 ) {
		return rgb;
    }
    rgb = rgb.match(/^rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+))?\)$/);
    function hex(x) {
        return ("0" + parseInt(x).toString(16)).slice(-2);
    }
    return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
}

function checkHex(hex){
	return /(^#[0-9A-F]{6}$)|(^#[0-9A-F]{3}$)/i.test(hex);
}










