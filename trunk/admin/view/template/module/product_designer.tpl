<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <h2><?php echo $text_product_options;?></h2>
		<table class="form">
          <tr>
            <td><span class="required">*</span><?php echo $text_option_save_design;?></td>
            <td>
	            <select name="pd_option_save_design">
	            	<?php foreach ($list_save_design_options as $key=>$name) {?>
	            		<option value="<?php echo $key;?>" <?php if ($pd_option_save_design == $key) echo "selected='selected'" ?>><?php echo $name;?></option>
	            	<?php } ?>
	            </select>
                <?php if ($error_option_save_design) { ?>
                	<span class="error"><?php echo $error_option_save_design; ?></span>
                <?php } ?>
			</td>
          </tr>
          <tr>
            <td><span class="required">*</span><?php echo $text_option_save_image;?></td>
            <td>
	            <select name="pd_option_save_image">
	            	<?php foreach ($list_save_image_options as $key=>$name) {?>
	            		<option value="<?php echo $key;?>" <?php if ($pd_option_save_image == $key) echo "selected='selected'" ?>><?php echo $name;?></option>
	            	<?php } ?>
	            </select>
                <?php if ($error_option_save_image) { ?>
                	<span class="error"><?php echo $error_option_save_image; ?></span>
                <?php } ?>
			</td>
          </tr>
          <tr>
            <td><span class="required">*</span><?php echo $text_option_save_text;?></td>
            <td>
	            <select name="pd_option_save_text">
	            	<?php foreach ($list_save_text_options as $key=>$name) {?>
	            		<option value="<?php echo $key;?>" <?php if ($pd_option_save_text == $key) echo "selected='selected'" ?>><?php echo $name;?></option>
	            	<?php } ?>
	            </select>
                <?php if ($error_option_save_text) { ?>
                	<span class="error"><?php echo $error_option_save_text; ?></span>
                <?php } ?>
			</td>
          </tr>
		  <tr>
            <td><span class="required">*</span><?php echo $text_option_save_font;?></td>
            <td>
	            <select name="pd_option_save_font">
	            	<?php foreach ($list_save_font_options as $key=>$name) {?>
	            		<option value="<?php echo $key;?>" <?php if ($pd_option_save_font == $key) echo "selected='selected'" ?>><?php echo $name;?></option>
	            	<?php } ?>
	            </select>
                <?php if ($error_option_save_font) { ?>
                	<span class="error"><?php echo $error_option_save_font; ?></span>
                <?php } ?>
			</td>
          </tr>
		  <tr>
            <td><span class="required">*</span><?php echo $text_option_save_text_color;?></td>
            <td>
	            <select name="pd_option_save_text_color">
	            	<?php foreach ($list_save_text_color_options as $key=>$name) {?>
	            		<option value="<?php echo $key;?>" <?php if ($pd_option_save_text_color == $key) echo "selected='selected'" ?>><?php echo $name;?></option>
	            	<?php } ?>
	            </select>
                <?php if ($error_option_save_text_color) { ?>
                	<span class="error"><?php echo $error_option_save_text_color; ?></span>
                <?php } ?>
			</td>
          </tr>
        </table>
		<h2><?php echo $text_size;?></h2>		
		<table class="form">
          <tr>
            <td><span class="required">*</span><?php echo $text_max_size_upload;?></td>
            <td>
	            <input type="text" name="pd_max_size_upload" value="<?php if ($pd_max_size_upload == null && $pd_max_size_upload == '') {echo "1024";}else {echo $pd_max_size_upload;}?>"/>
                <?php if ($error_max_size_upload) { ?>
                	<span class="error"><?php echo $error_max_size_upload; ?></span>
                <?php } ?>
			</td>
          </tr>
        </table>
        <h2><?php echo $text_text;?></h2>		
		<table class="form">
          <tr>
              <td><?php echo $text_enable_system_fonts;?></td>
              <td>
              		<input type="radio" name="pd_system_font_enable" value="1" <?php if ($pd_system_font_enable) echo "checked='checked'";?> />
                	<?php echo $text_yes; ?>
                	<input type="radio" name="pd_system_font_enable" value="0" <?php if (!$pd_system_font_enable) echo "checked='checked'";?>/>
                	<?php echo $text_no; ?>
              </td>
          </tr>
          <tr>
            <td><?php echo $text_add_link_google_fonts;?></td>
            <td>
	            <input type="text" id="pd_google_font" value=""  style="display:inline-block;"/>
                <a onclick="addGoogleFonts();" class="button"><?php echo $text_add_link;?></a>                
            </td>            
          </tr>
          <tr>
            <td><?php echo $text_add_color_text;?></td>
            <td>
	            <input type="text" id="pd_text_color" value=""  style="display:inline-block;"/>
                <a onclick="addColorText();" class="button"><?php echo $text_add_color;?></a>
            </td> 
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--

function addGoogleFonts(){
    $('#msg_fonts_google_remove').attr("style","display:none");
    $('#msg_fonts_google').attr("style","display:none");
    $('#msg_fonts_google_error').attr("style","display:none");
    var fonts = $('#fonts_google').val();    
	$.ajax({
		url: 'index.php?route=module/pcpb/addGoogleFonts&token=<?php echo $token; ?>',
        type: 'post',
		dataType: 'json',
        data: 'fonts=' + fonts,
		success: function(json){
		  if(json != null && json != "")
          {
            var nameFonts =  json.replace(/ /g, "");
			$('#msg_fonts_google').attr("style","display:inline-block");
            $('#pcpb_text_font').append("<option value="+ json +" id="+ nameFonts +">"+ json +"</option>");            
          }
          else
          {
            $('#msg_fonts_google_error').attr("style","display:inline-block");
          }
		},
        error: function(){
            $('#msg_fonts_google_error').attr("style","display:inline-block");
        }
	});
}
function removeGoogleFonts(){
    $('#msg_fonts_google_remove').attr("style","display:none");
    $('#msg_fonts_google').attr("style","display:none");
    $('#msg_fonts_google_error').attr("style","display:none");
    var fonts = $('#pcpb_text_font').val(); 
    var re = /((\s*\S+)*)\s*/;
    fonts = fonts.replace(re, "$1");   
	$.ajax({
		url: 'index.php?route=module/pcpb/removeGoogleFonts&token=<?php echo $token; ?>',
        type: 'post',
		dataType: 'json',
        data: 'fonts=' + fonts,
		success: function(json){
            var nameFonts =  fonts.replace(/ /g, "");
		    $('#'+nameFonts).remove();
			$('#msg_fonts_google_remove').attr("style","display:inline-block");        
		}
	});
}

function addColorText(){
    $('#msg_color_text_remove').attr("style","display:none");
    $('#msg_color_text').attr("style","display:none");
    $('#msg_color_text_error').attr("style","display:none");
    var color = $('#text_color').val();    
	$.ajax({
		url: 'index.php?route=module/pcpb/addColorText&token=<?php echo $token; ?>',
        type: 'post',
		dataType: 'json',
        data: 'color=' + color,
		success: function(json){
		  if(json != null && json != "")
          {
            var nameColor =  json.replace(/ /g, "");
            var nameN =  json.replace("#", "");
			$('#msg_color_text').attr("style","display:inline-block");
            $('#pcpb_text_color').append("<option value="+ json +" style='background:"+ nameColor +"' id="+ nameN +">"+ json +"</option>");                     $('#text_color').val("");    
          }
          else
          {
            $('#msg_color_text_error').attr("style","display:inline-block");
          }
		},
        error: function(){
            $('#msg_color_text_error').attr("style","display:inline-block");
        }
	});
}

function removeColorText(){
    $('#msg_color_text_remove').attr("style","display:none");
    $('#msg_color_text').attr("style","display:none");
    $('#msg_color_text_error').attr("style","display:none");
    var color = $('#pcpb_text_color').val(); 
    var re = /((\s*\S+)*)\s*/;
    color = color.replace(re, "$1");   
	$.ajax({
		url: 'index.php?route=module/pcpb/removeColorText&token=<?php echo $token; ?>',
        type: 'post',
		dataType: 'json',
        data: 'color=' + color,
		success: function(json){
            var nameColor =  color.replace("#", "");
		    $('#'+nameColor).remove();
			$('#msg_color_text_remove').attr("style","display:inline-block");     
            $('.color-list').css('background', $('.color-list').val());   
		}
	});
}
//--></script>
<link rel="stylesheet" type="text/css" href="view/javascript/pcpb/css/colorpicker.css" />
<script src="view/javascript/pcpb/js/colorpicker.js"></script>
<script>
$('#text_color').ColorPicker({
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
		$('#text_color').val('#' + hex);
	},
	onSubmit: function(hsb, hex, rgb) {
		$('#text_color').val('#' + hex);
	}
});

$(document).ready(function() {
    $('.colorpicker').css('z-index', '9999');
    $('.color-list').css('background', $('.color-list').val());
	$('.color-list').css('color','white');
	$('.color-list').children().css('color','white');
    $('.color-list').change(function() {
       var current = $('.color-list').val();
       if (current != 'null') {
           $('.color-list').css('background', current);
		   $('.color-list').css('color', 'white');
       } else {
           $('.color-list').css('background','white');
		   $('.color-list').css('color', 'black');
       }
    }); 
});
</script>
<?php echo $footer; ?>