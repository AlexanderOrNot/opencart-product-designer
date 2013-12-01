<head>
	<link rel="stylesheet" type="text/css" href="catalog/view/javascript/product_designer/css/colorpicker.css" />
	<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen"/>
    <link rel="stylesheet" type="text/css" href="catalog/view/javascript/product_designer/css/fontselector.css" />
	<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/stylesheet.css"/>
	<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.0/css/font-awesome.css">
	<link type="text/css" href="catalog/view/javascript/jquery/simplecolorpicker/jquery.simplecolorpicker.css" rel="stylesheet" />
	<link type="text/css" href="catalog/view/javascript/jquery/simplecolorpicker/jquery.simplecolorpicker-regularfont.css" rel="stylesheet" />
	<link type="text/css" href="catalog/view/javascript/jquery/simplecolorpicker/jquery.simplecolorpicker-glyphicons.css" rel="stylesheet" />
	<link type="text/css" href="catalog/view/javascript/jquery/simplecolorpicker/jquery.simplecolorpicker-fontawesome.css" rel="stylesheet" />
	
	<?php if(Count($list_link_google_fonts_options) > 0){?>
		<link href='http://fonts.googleapis.com/css?family=<?php for ($i = 0; $i < count($list_link_google_fonts_options); $i++) {
                        $fontName = trim($list_link_google_fonts_options[$i]);
                echo str_replace(" ", "+", $fontName)."|";
            } ?>' rel='stylesheet' type='text/css'/>
	<?php } ?>
	<script src="catalog/view/javascript/product_designer/jquery-1.7.2.min.js"></script>      
	<script src="catalog/view/javascript/product_designer/fabric.js"></script>
	<script src="catalog/view/javascript/product_designer/canvas2image.js"></script>
	<script src="catalog/view/javascript/product_designer/base64.js"></script>
	<script src="catalog/view/javascript/product_designer/product_designer.js"></script>
	<script src="catalog/view/javascript/product_designer/fabric.curvedText.js"></script>
	<script src="catalog/view/javascript/product_designer/jquery.ajaxupload.js"></script>  
	<script src="catalog/view/javascript/product_designer/js/colorpicker.js"></script>
	<script src="catalog/view/javascript/product_designer/js/eye.js"></script>
	<script src="catalog/view/javascript/product_designer/js/utils.js"></script>
	<script src="catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js"></script>
    <script src="catalog/view/javascript/product_designer/jquery.fontselector.js"></script>
	<script src="catalog/view/javascript/jquery/simplecolorpicker/jquery.simplecolorpicker.js"></script>
	<style>       
		.col-left{
			float: left;
			width: 56%;
			padding: 20px;
			display: block;
		}
		.col-right{
			float: right;
			width: 36%;
			padding: 20px;
			text-align: left;
			border-left: 1px solid #eee;
		}
		.canvas-container{
			margin: 0 auto;
		}
		p{
			margin-bottom: 10px;
		}
		.upload-image, .flip-image, .text-content, .text-fontsize, .text-color, .select-font, .text-effect{
			padding: 20px 0;
			border-bottom: 1px solid #eee;
		}
		.upload-image{
			padding-top: 0;
		}
		#option-text-border, #option-text-shadow, #option-text-curve{
			border: 1px solid #eee;
			padding: 10px 15px;
			background: #fafafa;
			display: none;
			margin-top: 20px;
		}
		table tr td{
			padding: 5px 10px;
		}
		table tr td h1{
			margin-bottom: 0;
		}
	</style>
	
	<script>
		$(function() {
			<?php foreach ($product_option_designers as $product_option_designer) {
				if(isset($product_option_designer['enable']) && $product_option_designer['enable'] == '1') { ?>      
				$('#pd-text-font').fontSelector({
					'hide_fallbacks' : true,
					'initial' : '<?php if(Count($list_link_google_fonts_options) > 0){ echo trim($list_link_google_fonts_options[0]); }?>,serif',
					'selected' : function() {pd.saveTextSetting();},
					'fonts' : [
						<?php $count = 0; 
						if(Count($list_link_google_fonts_options) > 0){ 
							for ($i = 0; $i < count($list_link_google_fonts_options); $i++) {
                                $fontName = trim($list_link_google_fonts_options[$i]); 
								if($count != count($list_link_google_fonts_options)-1){ ?>
								'<?php echo $fontName;?>,serif',                
							<?php $count ++; } 
							} ?>			
							'<?php echo trim($list_link_google_fonts_options[count($list_link_google_fonts_options)-1]);?>,serif'			
						<?php } ?>
						]
				});
			<?php } else { ?>
				$('#pd-text-font').fontSelector({
					'hide_fallbacks' : true,
					'initial' : '<?php if(Count($list_link_google_fonts_options) > 0){ echo trim($list_link_google_fonts_options[0]); }?>,serif',
					'selected' : function() {pd.saveTextSetting();},
					'fonts' : [
						'Arial,serif',
						'Times New Roman,serif',
						'Tahoma,serif',
						'Comic Sans MS,serif',
						'Courier New,serif',
						'Georgia,serif',
						'Lucida Console,serif',
						'Verdana,serif',
						<?php $count = 0; 
						if(Count($list_link_google_fonts_options) > 0){ 
							for ($i = 0; $i < count($list_link_google_fonts_options); $i++) {
                                $fontName = trim($list_link_google_fonts_options[$i]);  
								if($count != count($list_link_google_fonts_options)-1){ ?>
								'<?php echo $fontName;?>,serif',                
							<?php $count ++; } 
							} ?>			
							'<?php echo trim($list_link_google_fonts_options[count($list_link_google_fonts_options)-1]);?>,serif'
						<?php } ?>
						]
				});
			 <?php } ?>
		 <?php } ?>
		});
		
	</script>
	
</head>
<body>
	<div class="col-left">
		<canvas id="pd_canvas" width="<?php echo $width; ?>" height="<?php echo $height; ?>"></canvas>
	</div>
	<div class="col-right">
		<form method="post" action="index.php?route=product_designer/create/step2&product_id=<?php echo $product_id; ?>">
			<div class="upload-image">
				<p><strong>Upload image</strong></p> 
				<input type="button" class="button" id="pd-upload-image" value="Browse" />
			</div>
			<div class="flip-image">
				<p><strong>Flip image</strong></p> 
				<input id="pd-image-horizontal" type="button" value="<?php echo $text_Horizontal; ?>" class="button" onclick="pd.flipHorizontalImage()"/>
				<input id="pd-image-vertical" type="button" value="<?php echo $text_Vertical; ?>" class="button" onclick="pd.flipVerticalImage()"/>
			</div>
			<div class="text-content">
				<p><strong>Enter text</strong></p> 
				<textarea id="pd-text-content" rows="5" cols="50" onkeyup="pd.saveTextSetting();" onchange="pd.saveTextSetting();"></textarea>
			</div>
			<div class="text-fontsize">
				<p><strong>Font size</strong></p> 
				<select id="pd-text-fontsize" style="width: 153px;padding: 1px 0px;margin-left: 2px;" onchange="pd.saveTextSetting();">
					<?php for($i = 1; $i<101; $i++) {?>
						<option><?php echo $i;?></option>
					<?php } ?>
				</select>
			</div>
			<div class="text-color">
				<p><strong>Select color</strong></p> 
				<select id="colorpicker_picker" onchange="pd.saveTextSetting();">
                <?php for ($i = 0; $i < count($list_link_color_text_options); $i++) {
                    $colorName = str_replace(" ", "", $list_link_color_text_options[$i]);
                    ?>
				    <option value="<?php echo $colorName;?>"><?php echo $colorName;?></option>
		          <?php } ?>
				</select>
			</div>
			<div class="select-font">
				<p><strong>Select font</strong></p> 
				<div id="pd-text-font" class="fontSelect">
					<div class="arrow-down"></div>
				</div>
			</div>
			
			<div class="text-effect">
				<p><strong>Text effect</strong></p> 
				<input id="pd-text-border" type="button" value="<?php echo $text_Border; ?>" class="button"/>
				<input id="pd-text-shadow" type="button" value="<?php echo $text_Shadow; ?>" class="button"/>
				<input id="pd-text-curve" type="button" value="<?php echo $text_Curve; ?>" class="button"/>
				
				<div id="option-text-border">
					<table>
						<tr>
							<td>Color:</td>
							<td><input id="pd-border-color" type="text" value="#FFF" onchange="pd.borderText();" onkeyup="pd.borderText();"/></td>
							<td rowspan="2" style="border-left: 1px solid #ddd; padding-left: 55px;"><h1><?php echo $text_Border; ?></h1></td>
						</tr>
						<tr>
							<td>Border width:</td>
							<td><input type="range" min="1" max="5" value="1" id="pd-stroke-width" onchange="pd.borderText();" /></td>
						</tr>
					</table>
				</div>
				
				<div id="option-text-shadow">
					<table>
						<tr>
							<td>Color:</td>
							<td><input id="pd-shadow-color" type="text" value="#FFF" onchange="pd.shadowText();" onkeyup="pd.shadowText();"/></td>
							<td rowspan="4" style="border-left: 1px solid #ddd; padding-left: 33px;"><h1><?php echo $text_Shadow; ?></h1></td>
						</tr>
						<tr>
							<td>Horizontal offset:</td>
							<td><input type="range"  min="-20" max="20" value="1" id="pd-horizontal-offset" onchange="pd.shadowText();" /></td>
						</tr>
						<tr>
							<td>Vertical offset:</td>
							<td><input type="range"  min="-20" max="20" value="1" id="pd-vertical-offset" onchange="pd.shadowText();" /></td>
						</tr>
						<tr>
							<td>Blur size:</td>
							<td><input type="range"  min="1" max="20" value="5" id="pd-blur-size" onchange="pd.shadowText();" /></td>
						</tr>
					</table>
				</div>
				
				<div id="option-text-curve">
					<table>
						<tr>
							<td>Spacing: </td>
							<td><input type="range" min="-20" max="20" value="0" id="pd-spacing" onchange="pd.curvedTextSpacing();" /></td>
							<td rowspan="2" style="border-left: 1px solid #ddd; padding-left: 75px;"><h1><?php echo $text_Curve; ?></h1></td>
						</tr>
						<tr>
							<td>Radius: </td>
							<td><input type="range" min="-20" max="20" value="0" id="pd-radius" onchange="pd.curvedTextRadius();" /></td>
						</tr>
					</table>
				</div>
				
			</div>
			<div style="margin-top:20px">
				<input class="button" type="submit" value="Next" />
			</div>
		</form>
	</div>
<script type="text/javascript">

	//init for canvas manager
	var pd = new product_designer('pd_canvas');
	<?php if (!empty($background)) { ?>
		if(<?php echo $width;?> <= 600){
			pd.width  = <?php echo $width;?>;
			pd.height = <?php echo $height;?>;
			
		} else {
			$canvas_scale = 1 - (600 / <?php echo $width;?>) ;
			pd.width  = 600;
			pd.height = <?php echo $height;?> - (<?php echo $height;?> * $canvas_scale);
		}
		
		pd.setHeight(pd.height);
		pd.setWidth(pd.width);
		var originBG = '<?php echo $background;?>';
		pd.setBackgroundImage(originBG, pd.width, pd.height);
		
	<?php } ?>
	//var canvasScale = 1;
	//var SCALE_FACTOR = 1.8;
	//canvasScale = canvasScale / SCALE_FACTOR;
    //pd.setHeight(pd.height * (1 / SCALE_FACTOR));
    //pd.setWidth(pd.width * (1 / SCALE_FACTOR));
	
	
	//BEGIN ADD COLOR PICKER
	$('#colorpicker_picker').simplecolorpicker({picker: true, theme: 'fontawesome'});
	//END ADD COLOR PICKER
	
	$('#pd-border-color').ColorPicker({
		color: '#fff',
		onShow: function (colpkr) {
			$(colpkr).fadeIn(500);
			return false;
		},
		onHide: function (colpkr) {
			$(colpkr).fadeOut(500);
			return false;
		},
		onChange: function (hsb, hex, rgb) {
			$('#pd-border-color').val('#' + hex);
			pd.borderText();
		},
		onSubmit: function(hsb, hex, rgb) {
			$('#pd-border-color').val('#' + hex);
			pd.borderText();
		}
	});
	
	$('#pd-shadow-color').ColorPicker({
		color: '#fff',
		onShow: function (colpkr) {
			$(colpkr).fadeIn(500);
			return false;
		},
		onHide: function (colpkr) {
			$(colpkr).fadeOut(500);
			return false;
		},
		onChange: function (hsb, hex, rgb) {
			$('#pd-shadow-color').val('#' + hex);
			pd.shadowText();
		},
		onSubmit: function(hsb, hex, rgb) {
			$('#pd-shadow-color').val('#' + hex);
			pd.shadowText();
		}
	});
	
	$('#pd-upload-image').ajaxUploadPrompt({
		type: 'POST',
		url: 'index.php?route=product_designer/upload',
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
				pd.addImage(imagePath,'100','100');
			}
			$('#pd-upload-image').val('Reupload');
		}
	});
	
	$('#pd-text-border').click(function() {
		$('#option-text-border').slideToggle();
		if($('#pd-text-border').val() == '<?php echo $text_Border; ?>'){
			$('#pd-text-border').val("<?php echo $text_Remove_Border; ?>");
		}
		else if($('#pd-text-border').val() == '<?php echo $text_Remove_Border; ?>'){
			$('#pd-text-border').val("<?php echo $text_Border; ?>");
		}
		pd.borderText();
	});
	
	$('#pd-text-shadow').click(function() {
		$('#option-text-shadow').slideToggle();
		if($('#pd-text-shadow').val() == '<?php echo $text_Shadow; ?>'){
			$('#pd-text-shadow').val("<?php echo $text_Remove_Shadow; ?>");
		}
		else if($('#pd-text-shadow').val() == '<?php echo $text_Remove_Shadow; ?>'){
			$('#pd-text-shadow').val("<?php echo $text_Shadow; ?>");
		}
		pd.shadowText();
	});
	
	$('#pd-text-curve').click(function() {
		$('#option-text-curve').slideToggle();
		if($('#pd-text-curve').val() == '<?php echo $text_Curve; ?>'){
			$('#pd-text-curve').val("<?php echo $text_Remove_Curve; ?>");
		}
		else if($('#pd-text-curve').val() == '<?php echo $text_Remove_Curve; ?>'){
			$('#pd-text-curve').val("<?php echo $text_Curve; ?>");
		}
		pd.curveText();
	});
	
	
</script>
</body>