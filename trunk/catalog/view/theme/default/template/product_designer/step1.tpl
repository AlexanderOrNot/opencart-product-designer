<head>
	<link rel="stylesheet" type="text/css" href="catalog/view/javascript/pcpb/css/colorpicker.css" />
	<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen"/>
    <link rel="stylesheet" type="text/css" href="catalog/view/javascript/pcpb/css/fontselector.css" />
	<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/stylesheet.css"/>
    <link href='http://fonts.googleapis.com/css?family=<?php foreach ($list_link_google_fonts_options as $list_link_google_fonts) { 
                echo str_replace(" ", "+", $list_link_google_fonts['key'])."|";
            } ?>' rel='stylesheet' type='text/css'/>
	<script src="catalog/view/javascript/pcpb/jquery-1.7.2.min.js"></script>      
	<script src="catalog/view/javascript/pcpb/fabric.js"></script>
	<script src="catalog/view/javascript/pcpb/canvas2image.js"></script>
	<script src="catalog/view/javascript/pcpb/base64.js"></script>
	<script src="catalog/view/javascript/pcpb/PCPB.js"></script>
	<script src="catalog/view/javascript/pcpb/fabric.curvedText.js"></script>
	<script src="catalog/view/javascript/pcpb/jquery.ajaxupload.js"></script>  
	<script src="catalog/view/javascript/pcpb/js/colorpicker.js"></script>
	<script src="catalog/view/javascript/pcpb/js/eye.js"></script>
	<script src="catalog/view/javascript/pcpb/js/utils.js"></script>
	<script src="catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js"></script>
    <script src="catalog/view/javascript/pcpb/jquery.fontselector.js"></script>
	<style>       
		.btn{
			height:25px;
			margin-right: 15px;
			margin-top: 5px;
		}
		.border_3d{
			-webkit-box-shadow: 0px 1px 5px rgba(97, 97, 97, 0.75);
			-moz-box-shadow:    0px 1px 5px rgba(97, 97, 97, 0.75);
			box-shadow:         0px 1px 5px rgba(97, 97, 97, 0.75);
		}
		html{
			*overflow-y: auto;
			overflow: hidden;
		}
		.modalBackground {
			background-attachment: fixed;
			background-color: #FFFFFF;
			background-image: url("image/pcpb/loading.gif");
			background-position: center center;
			background-repeat: no-repeat;
			height: 100%;
			left: 0;
			opacity: 0.6;
			position: fixed;
			top: 0;
			width: 100%;
			z-index: 100000;
		}
        .pixel_color{
			width: 20px;
			height: 20px;
			display: inline-block;
			cursor: pointer;
		}
        table tr td.effect_text{
		    border-top: 1px solid #ddd;
		    padding: 10px 0;
		}
	</style>
	
	<!-- bxSlider Javascript file -->
	<script src="catalog/view/javascript/jquery/bxslider/jquery.bxslider.js"></script>
	<!-- bxSlider CSS file -->
	<link href="catalog/view/javascript/jquery/bxslider/jquery.bxslider.css" rel="stylesheet" />

	
</head>
<body style="margin:0;">
	<input type="hidden" name="product_option_value_id" value="<?php echo $product_option_value_id; ?>" />
	<input type="hidden" id="image_option_id" name="image_option_id" value="" />
	<input type="hidden" name="product_option_price" value="<?php echo $product_option_price; ?>" />
    <div style="float:right;">
        <input class="button" type="button" value="X" onclick="btnBackAndClose()" style="height: 22px;width: 22px;border-radius: 100%;text-align: center;padding: 0;"/>
    </div>
	<div style="margin:auto; width:<?php echo $width+700; ?>px; height:<?php echo $height; ?>px">               
		<div style="float:left; width:100%">            
            <div style="float:left; width:150px; background-color: #FFFFFF;">
                <div style="margin-top: 2px;">
                <?php if($add_text_enable == 1) { ?>
    				<input class="button btn" type="button" value="<?php echo $text_Add_Text; ?>" onclick="pcpb.addText('New Text',<?php echo $width; ?>,<?php echo $height; ?>)"/>
    			<?php } ?>
                </div>
                <div style="margin-top: 2px;">
    			<?php if($add_images_enable == 1) { ?>
    				<input type="button" class="button btn" value="<?php echo $text_Add_Image;?>" onclick="pcpb.addImage('image/pcpb/sample.jpg',<?php echo $width; ?>,<?php echo $height; ?>)"/>
    			<?php } ?>
                </div>                			
    			<div style="margin-top: 2px;">
    				<input type="button" class="button btn" value="Move to Front" onclick="pcpb.movetoFront()"/>
                </div>
                <div style="margin-top: 2px;">
    				<input type="button" class="button btn" value="Move to Back" onclick="pcpb.movetoBack()"/>
                </div>
                <?php if($change_bg_enable == 1) { ?>
                <div style="margin-top: 2px;">				
    				<input type="button" class="button btn" value="<?php echo $text_Reset_Background; ?>" onclick="setOriginBackground();" />
    			</div>
                <div style="margin-top: 2px;">
                	<input type="button" class="button btn" value="<?php echo $text_Change_Background; ?>" id="btn_change_background" onclick="btnChangeBackground()"/>				
                </div>	
                <?php } ?>
                <div style="margin-top: 2px;">
    				<input class="button" type="button" value="<?php echo $text_cancel_and_close; ?>" onclick="btnBackAndClose()"/>
                </div>
                <div style="margin-top: 2px;">
    				<input class="button" type="button" value="<?php echo $text_Back; ?>" onclick="btnBack()"/>
    		    </div>
                <div style="margin-top: 2px;">
                    <input class="button" type="button" onclick="finish()" value="<?php echo $text_Finish; ?>" />
    			</div>
            </div>
        <div>
		<fieldset class="border_3d" style="border: 1px solid #BBB; width:300px; min-height:<?php echo $height + 19; ?>px; float:left; margin-left:10px; display:inline-block;">
			<legend><?php echo $text_edit; ?></legend>			
			<div id="pcpb_edit_text" style="border: 1px solid #BBB;min-height:185px; display: none;">
				<div style="border-bottom: 1px solid #BBB;height: 13px; line-height: 13px; padding: 10px">
					<div style="float: right;font-size: 11px;">(<a href="javascript:void(0)" onclick="pcpb.copyActiveObject();"><?php echo $text_copy; ?></a>, <a href="javascript:void(0)" onclick="pcpb.deleteActiveObject();"><?php echo $text_delete; ?></a>)</div>
					<div style="float: left;font-weight: bold;"><?php echo $text_edit_text; ?></div>
				</div>
				<div>
					<table>
						<tr>
							<td style="padding-left: 20px;" width="90px" height="35px">*<?php echo $text_content; ?>:</td>
							<td><input id="pcpb_text_content" type="text" value="TEXT" onkeyup="pcpb.saveTextSetting();"/></td>
						</tr>
						<tr>
							<td style="padding-left: 27px;" height="35px"><?php echo $text_Font; ?>:</td>
							<td>
                                <div id="pcpb_text_font" class="fontSelect">
                                    <div class="arrow-down"></div>
                                </div>                                    
							</td>
						</tr>
						<tr>
							<td style="padding-left: 27px;" height="35px"><?php echo $text_Font_size; ?>:</td>
							<td>
								<select id="pcpb_text_fontsize" style="width: 153px;padding: 1px 0px;margin-left: 2px;" onchange="pcpb.saveTextSetting();">
								<?php for($i = 1; $i<101; $i++) {?>
									<option><?php echo $i;?></option>
								<?php } ?>
								</select>
							</td>
						</tr>
						<tr>
							<td style="padding-left: 27px;" height="35px"><?php echo $text_Color; ?>:</td>
							<td>
                                <?php foreach ($list_link_color_text_options as $list_link_color_text) { 
                                    $colorName = str_replace(" ", "", $list_link_color_text['key']);
                                    ?>
                                    <div class="pixel_color" style="background: <?php echo $colorName;?>;"><input type="hidden" value="<?php echo $colorName;?>" /></div>
                                    <?php
                                } ?>									
							</td>
							<input id="pcpb_text_color" type="hidden" value=""/>
<script>
$('.pixel_color').click(function() {
var color = $(this).children().val();  
$('#pcpb_text_color').val(color);
pcpb.saveTextSetting();
});
$(function() {
<?php if(isset($pcpb_enable) && (!$pcpb_enable)){ ?>        
$('#pcpb_text_font').fontSelector({
	'hide_fallbacks' : true,
	'initial' : '<?php echo $list_link_google_fonts_options[0]['key'];?>,serif',
    'selected' : function() {pcpb.saveTextSetting();},
	'fonts' : [
		<?php $count = 0; 
        foreach ($list_link_google_fonts_options as $list_link_google_fonts) { 
            if($count != count($list_link_google_fonts_options)-1){ ?>
        	'<?php echo $list_link_google_fonts['key'];?>,serif',                
        <?php $count ++; } 
        } ?>			
        '<?php echo $list_link_google_fonts_options[count($list_link_google_fonts_options)-1]['key'];?>,serif'			
		]
});
<?php } else { ?>
$('#pcpb_text_font').fontSelector({
	'hide_fallbacks' : true,
	'initial' : '<?php echo $list_link_google_fonts_options[0]['key'];?>,serif',
    'selected' : function() {pcpb.saveTextSetting();},
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
        foreach ($list_link_google_fonts_options as $list_link_google_fonts) { 
            if($count != count($list_link_google_fonts_options)-1){ ?>
        	'<?php echo $list_link_google_fonts['key'];?>,serif',                
        <?php $count ++; } 
        } ?>			
        '<?php echo $list_link_google_fonts_options[count($list_link_google_fonts_options)-1]['key'];?>,serif'            			
		]
});
 <?php } ?>
});

$('#pcpb_text_color').ColorPicker({
color: '#0000ff',
onShow: function (colpkr) {
	$(colpkr).fadeIn(500);
	return false;
},
onHide: function (colpkr) {
	$(colpkr).fadeOut(500);
	return false;
},
onChange: function (hsb, hex, rgb) {
	$('#pcpb_text_color').val('#' + hex);
	pcpb.saveTextSetting();
},
onSubmit: function(hsb, hex, rgb) {
	$('#pcpb_text_color').val('#' + hex);
	pcpb.saveTextSetting();
}
});
</script>
						</tr>
						<tr>
							    <td class="effect_text" style="padding-left: 27px;">Shadow:</td>
                                <td class="effect_text">
                                    <input id="pcpb_text_shadow" type="button" value="Text Shadow" class="button"/>
                                    <div id="shadow_option" style="display:none;"><br>
                                        color: <br>
                                        <input id="pcpb_shadow_color" type="text" value="#FFF" onchange="pcpb.shadowText();" onkeyup="pcpb.shadowText();"/>
                                        <br><br>
                                        horizontal offset: <br><input type="range"  min="-20" max="20" value="1" id="pcpb_horizontal_offset" onchange="pcpb.shadowText();" />
                                        <br>
                                        vertical offset: <br><input type="range"  min="-20" max="20" value="1" id="pcpb_vertical_offset" onchange="pcpb.shadowText();" />
                                        <br>
                                        blur size: <br><input type="range"  min="1" max="20" value="5" id="pcpb_blur_size" onchange="pcpb.shadowText();" />
										
                                    </div>
                                </td>
							</tr>
							<tr>
							    <td class="effect_text" style="padding-left: 27px;">Border:</td>
                                <td class="effect_text">
                                    <input id="pcpb_text_border" type="button" value="Text Border" class="button" onclick="pcpb.borderText();"/>
                                    <div id="border_option" style="display:none;"><br>
                                        color: <br>
                                        <input id="pcpb_border_color" type="text" value="#FFF" onchange="pcpb.borderText();" onkeyup="pcpb.borderText();"/>
                                        <br><br>
                                        border width: <input type="range"  min="1" max="5" value="1" id="pcpb_stroke_width" onchange="pcpb.borderText();" />
                                    </div>
                                </td>
                            </tr>
							<tr>
							    <td class="effect_text" style="padding-left: 27px;">Curved Text:</td>
                                <td class="effect_text">
                                    <input id="pcpb_text_curved" type="button" value="Text Curved" class="button" onclick="pcpb.curvedText();"/>
                                    <div id="border_option" style="display:none;"><br>
                                        color: <br>
                                        <input id="pcpb_border_color" type="text" value="#FFF" onchange="pcpb.borderText();" onkeyup="pcpb.borderText();"/>
                                        <br><br>
                                        border width: <input type="range"  min="1" max="5" value="1" id="pcpb_stroke_width" onchange="pcpb.borderText();" />
                                    </div>
                                </td>
                            </tr>
					</table>
				</div>
			</div>
			<div id="pcpb_edit_image" style="border: 1px solid #BBB;height: 140px; display: none;">
				<div style="border-bottom: 1px solid #BBB;height: 13px; line-height: 13px; padding: 10px">
					<div style="float: right;font-size: 11px;">(<a href="javascript:void(0)" onclick="pcpb.copyActiveObject();"><?php echo $text_copy; ?></a>, <a href="javascript:void(0)" onclick="pcpb.deleteActiveObject();"><?php echo $text_delete; ?></a>)</div>
					<div style="float: left;font-weight: bold;"><?php echo $text_Edit_Image; ?></div>
				</div>
				<div>
					<div style="height: 35px; line-height:35px; margin-left: 20px;">
						<?php echo $text_Upload; ?>: <input id="pcpb_image_upload" onclick="return false;" type="file" style="width: 200px; margin-left: 15px;"/>
					</div>
					<div style="height: 35px; line-height:35px; margin-left: 20px;">
						<?php echo $text_Select_from_list; ?>: <input id="pcpb_image_select" class="button" type="button" value="Select" onclick="changeImage();" style="margin-left: 111px;"/>
					</div>
					<div style="height: 35px; line-height:35px; margin-left: 20px;">
						<?php echo $text_Flip; ?>:
						<input id="pcpb_image_horizontal" type="button" value="<?php echo $text_Horizontal; ?>" class="button" style="margin-left: 80px;" onclick="pcpb.flipHorizontalImage()"/>
						<input id="pcpb_image_vertical" type="button" value="<?php echo $text_Vertical; ?>" class="button" onclick="pcpb.flipVerticalImage()"/>
					</div>
				</div>
			</div>
			<div id="pcpb_edit_background" style="border: 1px solid #BBB;height: 110px; display: none;">
				<div style="height: 13px; line-height: 13px; padding: 10px">
					<div style="float: left;font-weight: bold;"><?php echo $text_Edit_Background; ?></div>
				</div>
				<div>
					<div style="height: 35px; line-height:35px; margin-left: 20px;">
						<?php echo $text_Upload; ?>: <input id="pcpb_background_upload" onclick="return false;" type="file" style="width: 200px; margin-left: 15px;"/>
					</div>
					<div style="height: 35px; line-height:35px; margin-left: 20px;">
						<?php echo $text_Dimension_required; ?>: <?php echo $width . ' x ' . $height; ?>
					</div>
				</div>
			</div>        
		</fieldset>
		<fieldset class="border_3d" style="float:left; margin-left:10px; border: 1px solid #BBB">
			<legend><?php echo $text_Custom_your_product; ?></legend>
			<div>
				<canvas id="pcpb_canvas" width="<?php echo $width; ?>" height="<?php echo $height; ?>" style="border: 1px solid #DDD"></canvas>
				
				<img src="catalog/view/theme/default/image/rotate.png" id="icon-rotate" style="display:none; cursor:pointer" onclick="pcpb.rotateActiveObject();"/>
				<img src="catalog/view/theme/default/image/delete.png" id="icon-delete" style="display:none; cursor:pointer" onclick="pcpb.deleteActiveObject();"/>
			</div>
			<div style="margin-top: 5px;" id="btn-pcpb">
				<div id="selector-layout" style="display:none;width:100%;margin:10px 0;padding: 10px 0;height: 100px;"><ul class="bxslider" style="margin:0;"></ul>
            </div>				
			</div>
		</fieldset>             
        </div>
	</div>
	<div id="spinner" class="modalBackground" style="display: none;"></div>
	
</body>