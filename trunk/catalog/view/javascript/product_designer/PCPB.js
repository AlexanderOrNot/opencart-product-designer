function PCPB(id, viewOnly){
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
				THIS.selectedTarget();
			} 
			else{
				$('#pcpb_edit_text,#pcpb_edit_image,#pcpb_edit_background').hide();
			}
		});
	}
	this.selectedTarget = function(){
		var c = this._canvas;
		var t = c.getActiveObject();
		//if(t == null)
			$('#pcpb_edit_text,#pcpb_edit_image,#pcpb_edit_background').hide();
		if(t.type=='text' || t.type=='curvedText'){
			//text
			$('#pcpb_text_content').val(t.getText());
			$('#pcpb_text_font').val(t.getFontFamily());
			$('#pcpb_text_fontsize').val(t.getFontSize());
			$('#pcpb_text_color').val(rgb2hex(t.getFill()));
			$('#pcpb_edit_image').hide();
			$('#pcpb_edit_text').show();
		}else if(t.type=='image'){
			//image
			$('#pcpb_edit_text').hide();
			$('#pcpb_edit_image').show();
			if(changeImageInit == false){
				changeImageInit = true;
				$('#pcpb_image_upload').ajaxUploadPrompt({
					type: 'POST',
					url: 'index.php?route=pcpb/upload',
					dataType: 'json',
					success: function(datas){
						if(typeof(datas) == 'string')
						{
							//fix for IE problem
							eval('datas = ' + datas);
						}
						if(datas.errorCode != 0)
							alert(datas.errorMessage);
						else{
							var imagePath = datas.imagePath;
							pcpb.setCurrentImagePath(imagePath,datas.size['0'],datas.size['1']);
						}
					}
				});
			}
		}
		
		positionBtnRotate(t);
		positionBtnDelete(t);
		
	};
	var flag1 = true;
	this.addText = function(content,width_img,height_img){	
		
		//resize popup
		//var width = screen.availWidth;
//		var height = screen.availHeight - 100;
		var changeBGInit = false;
		var changeImageInit = false;
		//if(flag1 == true){
//			parent.resizePopupPCPB(width, height);
//			flag1 = false;
//		}
		
		var c = this._canvas;
		var text = new fabric.Text(content, {
			top: 18,
			left: 50,
			fontSize: 25,
			cornerSize: 5,
			borderColor: 'red',
			cornerColor: 'green',
		});
		text.lockScalingX = text.lockScalingY = true;
		
		positionBtnRotate(text);
		positionBtnDelete(text);
		text.on('moving', function() { positionBtnRotate(text) });
		text.on('moving', function() { positionBtnDelete(text) });
		
		c.add(text);
		c.setActiveObject(text);
				
        c.setZIndex = 1;
		$('#selector-layout').show();
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
		this.selectedTarget();
	};
	
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
		var textObject = c.getActiveObject();        
        if(c.getObjects().length > 0){
        if(textObject.type != 'text')
			return;
		textObject.setText($('#pcpb_text_content').val());
        var fonts = $('#pcpb_text_font').text();
        var re = /((\s*\S+)*)\s*/;
        fonts = fonts.replace(re, "$1");
		textObject.setFontFamily(fonts);
		textObject.setFontSize(parseInt($('#pcpb_text_fontsize').val()));
		var hex = $('#pcpb_text_color').val();
		if(checkHex(hex))
			textObject.setFill(hex);
			
		c.renderAll();
		
		$('ul.bxslider').find('li.item_'+ c.getObjects().indexOf(textObject)).children().children().css('font-family',textObject.getFontFamily());
		$('ul.bxslider').find('li.item_'+ c.getObjects().indexOf(textObject)).children().children().css('font-size','18px');
		$('ul.bxslider').find('li.item_'+ c.getObjects().indexOf(textObject)).children().children().css('color',textObject.getFill());
		$('ul.bxslider').find('li.item_'+ c.getObjects().indexOf(textObject)).children().children().html(textObject.text);
		
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
	this.deleteActiveObject = function(){
		var c = this._canvas;
		var o = c.getActiveObject();
		c.remove(o);
		c.renderAll();
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
		$('#icon-move').css('display','none');
		$('#icon-rotate').css('display','none');
		$('#icon-delete').css('display','none');
		$('#icon-resize').css('display','none');
		slider.reloadSlider();
		$('ul.bxslider').find('li.item_'+ c.getObjects().indexOf(c.getActiveObject())).children().css('border','1px solid #38B0E3');
		//this.selectedTarget();
	};
	this.copyActiveObject = function(){
		var c = this._canvas;
		var no = fabric.util.object.clone(c.getActiveObject());
		no.set("top", no.height/2);
        no.set("left", no.width/2);
		c.add(no);
		$('ul.bxslider li').remove();
		$('ul.bxslider').find('li.item_'+ c.getObjects().indexOf(c.getActiveObject())).children().css('border','0');
		var index = c.getObjects().length - 1;
		c.forEachObject(function(obj){
			if(obj.type == 'text') {
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
		this.selectedTarget();
	};
	this.addImage = function(url,width_img,height_img){	
		//resize popup
		//var width = 300 + 150 + width_img;
//		if(width < 910)
//			width = 910;
//		var height = 140 + 150 + height_img;
		var changeBGInit = false;
		var changeImageInit = false;
		//if(flag1 == true){
//			parent.resizePopupPCPB(width, height);
//			flag1 = false;
//		}
		
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
			
			positionBtnMove(img);
			positionBtnRotate(img);
			positionBtnDelete(img);
			positionBtnResize(img);
		img.on('moving', function() { positionBtnRotate(img) });
		img.on('moving', function() { positionBtnDelete(img) });
			
			$('#selector-layout').show();
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
			THIS.selectedTarget();
		});
	};
	
	this.shadowText = function(){
		var c = this._canvas;
		var textObject = c.getActiveObject();
		if(textObject.type != 'text')
			return;
        if($('#pcpb_text_shadow').val() == 'Remove Shadow'){
            textObject.set({shadow: $('#pcpb_shadow_color').val() + ' ' + $('#pcpb_horizontal_offset').val() + ' ' + $('#pcpb_vertical_offset').val() + ' ' + $('#pcpb_blur_size').val() });
        }
        else if($('#pcpb_text_shadow').val() == 'Text Shadow'){
            textObject.set({shadow: $('#pcpb_shadow_color').val() + ' 0 0 0' });
        }
		c.renderAll();
	};


    this.borderText = function(){
        var c = this._canvas;
        var textObject = c.getActiveObject();
        if(textObject.type != 'text')
            return;
        if($('#pcpb_text_border').val() == 'Remove Border'){
            textObject.set({ stroke: $('#pcpb_border_color').val(), strokeWidth: $('#pcpb_stroke_width').val() });
        }
        else if($('#pcpb_text_border').val() == 'Text Border'){
            textObject.set({ stroke: 'none', strokeWidth: 0 });
        }

        c.renderAll();
    };
	var canvas = new fabric.Canvas('pcpb_canvas');
	
	this.curvedText = function(){
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
                props['radius'] = 50;
                props['spacing'] = 20;
                var textSample = new fabric.CurvedText(default_text, props);
            }
            c.remove(obj);
            c.add(textSample).renderAll();
            c.setActiveObject(c.item(c.getObjects().length-1));
			THIS.selectedTarget();
        }
		
    };
	
	
	//button Move to Front
	this.movetoFront = function(){
		var c = this._canvas;
		if(c.getActiveObject() != null){
			c.getActiveObject().bringForward();
		}
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
	};
	var flag = true;
	//button Move to Back
	this.movetoBack = function(){
		var c = this._canvas;
		if(c.getActiveObject() != null){
			if(c.getObjects().indexOf(c.getActiveObject()) != 0) {
				c.getActiveObject().sendBackwards();
				$('ul.bxslider li').remove();
				$('ul.bxslider').find('li.item_'+ c.getObjects().indexOf(c.getActiveObject())).children().css('border','0');
		var index = c.getObjects().length - 1 ;
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
			}
			else {
			
				fabric.Image.fromURL(c.backgroundImage.src, function(img) {
					img.set({
						top:c.height/2,
						left:c.width/2,
						width: c.width,
						height: c.height,
						cornerSize: 5,
						borderColor: 'red',
						cornerColor: 'green',
						selectable: false						
					})
					if(flag==true) {
						c.add(img);
						c.setActiveObject(img);
						c.getActiveObject().sendToBack();
						c.setActiveObject(c.item(1));
						c.getActiveObject().sendToBack();
						flag=false;
						$('ul.bxslider li').remove();
						$('ul.bxslider').find('li.item_'+ c.getObjects().indexOf(c.getActiveObject())).children().css('border','0');
		var index = c.getObjects().length - 1 ;
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
					}
				});
				
				
			}
			
		}
	};
	
	//set active object
	this.setActive = function(index){
		var c = this._canvas;
		$('ul.bxslider').find('li.item_'+ c.getObjects().indexOf(c.getActiveObject())).children().css('border','0');
		c.setActiveObject(c.item(index));
		$('ul.bxslider').find('li.item_'+ c.getObjects().indexOf(c.getActiveObject())).children().css('border','1px solid #38B0E3');
		
		this.selectedTarget();
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
			THIS.selectedTarget();
		});
	};
	this.setWidth = function(width){
		this._canvas.setWidth(width);
	};
	this.setHeight = function(height){
		this._canvas.setHeight(height);
	};
	this.setBackgroundImage = function(url){
		var c = this._canvas;
		if(flag == false){
			c.forEachObject(function(obj){
				if(obj.type == 'image') {
					if(obj.getSrc() == c.backgroundImage.src) {
						c.remove(obj);
						flag = true;
					}
				}
			});
		}
		c.setBackgroundImage(url, function(){c.renderAll();});
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










