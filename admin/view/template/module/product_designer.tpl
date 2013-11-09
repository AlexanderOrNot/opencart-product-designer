<?php echo $header; ?>
<style>
  #sortable-google-fonts, #sortable-text-color { list-style-type: none;padding: 0;display:table;}
  #sortable-google-fonts{ width: 230px}
  #sortable-text-color{ width:150px;}
  #sortable-google-fonts li, #sortable-text-color li { padding: 10px;height:15px;border-bottom:1px dashed #ddd;}
  #sortable-google-fonts li:last-child, #sortable-text-color li:last-child { border-bottom:none;}
  #sortable-google-fonts li:hover, #sortable-text-color li:hover{ background: #f0f0f0;}
  #sortable-text-color li span.colorcode { width:50px; float:left; }
  #sortable-text-color li span.color{ width:15px; height:15px; margin: 0 20px; float:left;}
  #sortable-google-fonts li span.close, #sortable-text-color li span.close{ float:right;cursor:pointer;}
</style>
<script>
  $(function() {
    $( "#sortable-google-fonts" ).sortable();
    $( "#sortable-google-fonts" ).disableSelection();
	$( "#sortable-text-color" ).sortable();
    $( "#sortable-text-color" ).disableSelection();
  });
  </script>
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
                	<input type="radio" name="pd_system_font_enable" value="0" <?php if ($pd_system_font_enable) echo "checked='checked'";?>/>
                	<?php echo $text_no; ?>
              </td>
          </tr>
          <tr>
            <td><?php echo $text_add_link_google_fonts;?></td>
            <td>
	            <input type="text" id="pd_google_font" value=""  style="display:inline-block;"/>
                <a onclick="addGoogleFonts();" class="button" style="margin-left: 10px"><?php echo $text_add_link;?></a>
				<ul id="sortable-google-fonts">
					<li>
						<span style="font-family: Time new roman">Time New Roman</span>
						<span class="close fa fa-times"></span>
					</li>
					<li>
						<span style="font-family: Arial">Arial</span>
						<span class="close fa fa-times"></span>
					</li>
				</ul>
            </td>            
          </tr>
          <tr>
            <td><?php echo $text_add_color_text;?></td>
            <td>
				<select id="pd_text_color" name="colorpicker-picker">
				  <option value="#ac725e">#ac725e</option>
				  <option value="#d06b64">#d06b64</option>
				  <option value="#f83a22">#f83a22</option>
				  <option value="#fa573c">#fa573c</option>
				  <option value="#ff7537">#ff7537</option>
				  <option value="#ffad46">#ffad46</option>
				  <option value="#42d692">#42d692</option>
				  <option value="#16a765">#16a765</option>
				  <option value="#7bd148">#7bd148</option>
				  <option value="#b3dc6c">#b3dc6c</option>
				  <option value="#fbe983">#fbe983</option>
				  <option value="#fad165">#fad165</option>
				  <option value="#92e1c0">#92e1c0</option>
				  <option value="#9fe1e7">#9fe1e7</option>
				</select>
                <a id="addTextColor" class="button" style="margin-left: 10px"><?php echo $text_add_color;?></a>
				<div style="margin-top:15px;">
					<ul id="sortable-text-color">
						<li>
							<span class="colorcode" style="color:#ff7537;">#ff7537</span>
							<span class="color" style="background: #ff7537;"></span>
							<span class="close fa fa-times"></span>
						</li>
						<li>
							<span class="colorcode" style="color:#92e1c0;">#92e1c0</span>
							<span class="color" style="background: #92e1c0;"></span>
							<span class="close fa fa-times"></span>
						</li>
					</ul>
				</div>
            </td> 
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript">
	//BEGIN ADD COLOR PICKER
	$('select[name="colorpicker-picker"]').simplecolorpicker({picker: true, theme: 'fontawesome'});
	//END ADD COLOR PICKER
	
	$('.close').click(function(){
		$(this).parent().remove();
	});
	
	$('#addTextColor').click(function(){
		$('ul#sortable-text-color').append('<li><span class="colorcode" style="color:'+ $('span.simplecolorpicker').attr('title') +'">'+ $('span.simplecolorpicker').attr('title') +'</span><span class="color" style="background: '+ $('span.simplecolorpicker').attr('title') +'"></span><span class="close fa fa-times"></span></li>');
	});
	
</script>
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
<?php echo $footer; ?>