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
			background: #298892;
			padding: 20px;
		}
		.col-right{
			float: right;
			width: 36%;
			padding: 20px;
			text-align: left;
			border-left: 1px solid #eee;
		}
		p{
			margin-bottom: 10px;
		}
		.upload-image, .flip-image, .text-content, .select-font, .text-effect{
			padding: 20px 0;
			border-bottom: 1px solid #eee;
		}
	</style>
	
	<script>
		$(function() {
			<?php foreach ($product_option_designers as $product_option_designer) {
				if(isset($product_option_designer['enable']) && $product_option_designer['enable'] == '1') { ?>      
				$('#pd-text-font').fontSelector({
					'hide_fallbacks' : true,
					'initial' : '<?php if(Count($list_link_google_fonts_options) > 0){ echo trim($list_link_google_fonts_options[0]); }?>,serif',
					'selected' : function() {},
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
					'selected' : function() {},
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
		<canvas id="pd_canvas" width="100%" height="100%" style="border: 1px solid #eee"></canvas>
	</div>
	<div class="col-right">
		<form method="post" action="index.php?route=product_designer/create/step2">
			<div class="upload-image">
				<p><strong>Upload image</strong></p> 
				<input id="pd-upload-image" onclick="return false;" type="file"/>
			</div>
			<div class="flip-image">
				<p><strong>Flip image</strong></p> 
				<input id="pd-image_horizontal" type="button" value="<?php echo $text_Horizontal; ?>" class="button" onclick="pd.flipHorizontalImage()"/>
				<input id="pd-image-vertical" type="button" value="<?php echo $text_Vertical; ?>" class="button" onclick="pd.flipVerticalImage()"/>
			</div>
			<div class="text-content">
				<p><strong>Enter text</strong></p> 
				<textarea rows="5" cols="50"></textarea>
			</div>
			<div class="select-font">
				<p><strong>Select font</strong></p> 
				<div id="pd-text-font" class="fontSelect">
					<div class="arrow-down"></div>
				</div>
			</div>
			<div class="select-font">
				<p><strong>Select color</strong></p> 
				<select id="colorpicker_picker">
				  <?php for ($i = 0; $i < count($list_link_color_text_options); $i++) {
                        $colorName = str_replace(" ", "", $list_link_color_text_options[$i]);?>
				        <option value="<?php echo $colorName;?>"><?php echo $colorName;?></option>
                  <?php } ?>				  
				</select>
			</div>
			<div class="text-effect">
				<p><strong>Text effect</strong></p> 
			</div>
			<div style="margin-top:20px">
				<input class="button" type="submit" value="Next" />
			</div>
		</form>
	</div>
<script type="text/javascript">
	//BEGIN ADD COLOR PICKER
	$('#colorpicker_picker').simplecolorpicker({picker: true, theme: 'fontawesome'});
	//END ADD COLOR PICKER
	
	//init for canvas manager
	var pd = new Product_designer('pd_canvas');
	alert($background);
	<?php if (!empty($background)) { ?>
		var originBG = '<?php echo $background;?>';
		pd.setBackgroundImage(originBG);
	<?php } ?>
	
</script>
</body>