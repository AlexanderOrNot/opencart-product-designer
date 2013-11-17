<head>
	<link rel="stylesheet" type="text/css" href="catalog/view/javascript/product_designer/css/colorpicker.css" />
	<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen"/>
    <link rel="stylesheet" type="text/css" href="catalog/view/javascript/product_designer/css/fontselector.css" />
	<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/stylesheet.css"/>
	<?php if(Count($list_link_google_fonts_options) > 0){?>
		<link href='http://fonts.googleapis.com/css?family=<?php foreach ($list_link_google_fonts_options as $list_link_google_fonts) { 
                echo str_replace(" ", "+", $list_link_google_fonts['key'])."|";
            } ?>' rel='stylesheet' type='text/css'/>
	<?php } ?>
	<script src="catalog/view/javascript/product_designer/jquery-1.7.2.min.js"></script>      
	<script src="catalog/view/javascript/product_designer/fabric.js"></script>
	<script src="catalog/view/javascript/product_designer/canvas2image.js"></script>
	<script src="catalog/view/javascript/product_designer/base64.js"></script>
	<script src="catalog/view/javascript/product_designer/PCPB.js"></script>
	<script src="catalog/view/javascript/product_designer/fabric.curvedText.js"></script>
	<script src="catalog/view/javascript/product_designer/jquery.ajaxupload.js"></script>  
	<script src="catalog/view/javascript/product_designer/js/colorpicker.js"></script>
	<script src="catalog/view/javascript/product_designer/js/eye.js"></script>
	<script src="catalog/view/javascript/product_designer/js/utils.js"></script>
	<script src="catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js"></script>
    <script src="catalog/view/javascript/product_designer/jquery.fontselector.js"></script>
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
		}
		p{
			margin-bottom: 10px;
		}
		.upload-image, .flip-image, .text-content, .select-font{
			margin-bottom: 20px;
		}
	</style>
	
	<script>
		$(function() {
			<?php foreach ($product_option_designers as $product_option_designer) {
				if(isset($product_option_designer['enable']) && $product_option_designer['enable'] == '1') { ?>      
				$('#pd-text-font').fontSelector({
					'hide_fallbacks' : true,
					'initial' : '<?php if(Count($list_link_google_fonts_options) > 0){ echo $list_link_google_fonts_options[0]['key']; }?>,serif',
					'selected' : function() {},
					'fonts' : [
						<?php $count = 0; 
						if(Count($list_link_google_fonts_options) > 0){ 
							foreach ($list_link_google_fonts_options as $list_link_google_fonts) { 
								if($count != count($list_link_google_fonts_options)-1){ ?>
								'<?php echo $list_link_google_fonts['key'];?>,serif',                
							<?php $count ++; } 
							} ?>			
							'<?php echo $list_link_google_fonts_options[count($list_link_google_fonts_options)-1]['key'];?>,serif'			
						<?php } ?>
						]
				});
			<?php } else { ?>
				$('#pd-text-font').fontSelector({
					'hide_fallbacks' : true,
					'initial' : '<?php if(Count($list_link_google_fonts_options) > 0){ echo $list_link_google_fonts_options[0]['key']; }?>,serif',
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
							foreach ($list_link_google_fonts_options as $list_link_google_fonts) { 
								if($count != count($list_link_google_fonts_options)-1){ ?>
								'<?php echo $list_link_google_fonts['key'];?>,serif',                
							<?php $count ++; } 
							} ?>			
							'<?php echo $list_link_google_fonts_options[count($list_link_google_fonts_options)-1]['key'];?>,serif'
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
		sdkfjdks
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
			<div>
				<input class="button" type="submit" value="Next" />
			</div>
		</form>
	</div>
</body>