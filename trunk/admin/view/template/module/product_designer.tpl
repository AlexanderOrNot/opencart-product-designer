<?php echo $header; ?>
<link id="" href='http://fonts.googleapis.com/css?family=<?php for ($i = 0; $i < count($list_link_google_fonts_options); $i++) {
    $fontName = trim($list_link_google_fonts_options[$i]);
    echo str_replace(" ", "+", $fontName)."|";
} ?>' rel='stylesheet' type='text/css'/>
<style>
  #sortable_google_fonts, #sortable_text_color { list-style-type: none;padding: 0;display:table;}
  #sortable_google_fonts{ width: 230px}
  #sortable_text_color{ width:150px;}
  #sortable_google_fonts li, #sortable_text_color li { padding: 10px;height:15px;border-bottom:1px dashed #ddd;}
  #sortable_google_fonts li:last-child, #sortable_text_color li:last-child { border-bottom:none;}
  #sortable_google_fonts li:hover, #sortable_text_color li:hover{ background: #f0f0f0;}
  #sortable_text_color li span.colorcode { width:50px; float:left; }
  #sortable_text_color li span.color{ width:15px; height:15px; margin: 0 20px; float:left;}
  #sortable_google_fonts li span.close, #sortable_text_color li span.close{ float:right;cursor:pointer;}
</style>
<script>
  $(function() {
    $( "#sortable_google_fonts" ).sortable();
    $( "#sortable_google_fonts" ).disableSelection();
	$( "#sortable_text_color" ).sortable();
    $( "#sortable_text_color" ).disableSelection();
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
      <div class="buttons"><a onclick="save();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
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
	            <input type="text" id="google_fonts" value=""  style="display:inline-block;"/>
                <a onclick="addGoogleFonts();" class="button" style="margin-left: 10px"><?php echo $text_add_link;?></a>
                <div style="display:none;" id="msg_fonts_google_error" class="warning">
	               <span>Link not exist</span>
                </div>
				<ul id="sortable_google_fonts">
                    <?php for ($i = 0; $i < count($list_link_google_fonts_options); $i++) {
                        $fontName = trim($list_link_google_fonts_options[$i]);?>
                        <li>
    						<span style="font-family:<?php echo $fontName;?>"><?php echo $fontName;?></span>
    						<span class="close fa fa-times"></span>
    					</li>       
                    <?php } ?>					
				</ul>
                <input id="pd_google_font" type="hidden" value="" name="pd_google_font"/>
            </td>            
          </tr>
          <tr>
            <td><?php echo $text_add_color_text;?></td>
            <td>
				<select id="colorpicker_picker">
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
					<ul id="sortable_text_color">
                        <?php for ($i = 0; $i < count($list_link_color_text_options); $i++) {
                            $colorName = str_replace(" ", "", $list_link_color_text_options[$i]);
                            ?>
                            <li>
                                <span class="colorcode" style="color: <?php echo $colorName;?>"><?php echo $colorName;?></span>
    							<span class="color" style="background: <?php echo $colorName;?>;"></span>
    							<span class="close fa fa-times"></span>
                            </li>       
                        <?php } ?>						
					</ul>
                    <input id="pd_text_color" type="hidden" value="" name="pd_text_color"/>
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
	$('#colorpicker_picker').simplecolorpicker({picker: true, theme: 'fontawesome'});
	//END ADD COLOR PICKER
	
	$('.close').click(function(){
		$(this).parent().remove();
	});
    
    function save(){
        setValueColors();
        setValueFonts();
        $('#form').submit();
    }
    
    function setValueColors(){
    	var listColors = document.getElementById('sortable_text_color');
        var list_items = listColors.getElementsByTagName("li");
        var colors = "";
        for (var i=0; i < list_items.length; i++)
        {
            if(colors == "")
            {
                colors = list_items[i].textContent;
            }
            else
            {
                colors = colors + "," + list_items[i].textContent;    
            }                   
        }
        $('#pd_text_color').val(colors);
    }
    
    function setValueFonts(){
    	var listFonts = document.getElementById('sortable_google_fonts');
        var list_items = listFonts.getElementsByTagName("li");
        var fonts = "";
        for (var i=0; i < list_items.length; i++)
        {
            if(fonts == "")
            {
                fonts = list_items[i].textContent;
            }
            else
            {
                fonts = fonts + "," + list_items[i].textContent;    
            }                   
        }
        $('#pd_google_font').val(fonts);
    }
    
	$('#addTextColor').click(function(){
		$('ul#sortable_text_color').append('<li><span class="colorcode" style="color:'+ $('span.simplecolorpicker').attr('title') +'">'+ $('span.simplecolorpicker').attr('title') +'</span><span class="color" style="background: '+ $('span.simplecolorpicker').attr('title') +'"></span><span class="close fa fa-times"></span></li>');
	});
</script>
<script type="text/javascript"><!--

function addGoogleFonts(){
    $('#msg_fonts_google_error').attr("style","display:none");
    var fonts = $('#google_fonts').val();    
	$.ajax({
		url: 'index.php?route=module/product_designer/addGoogleFonts&token=<?php echo $token; ?>',
        type: 'post',
		dataType: 'json',
        data: 'fonts=' + fonts,
		success: function(json){
		  if(json != null && json != "")
          {
            $('ul#sortable_google_fonts').append('<li><span style="font-family: '+ json +'">'+ json +'</span><span class="close fa fa-times"></span></li>');    
            $('#msg_fonts_google_error').attr("style","display:none"); 
            var nameFonts =  json.replace(/ /g, "+");   
            $('#header').after('<link type="text/css" rel="stylesheet" href="http://fonts.googleapis.com/css?family='+ nameFonts +'">');   
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

//--></script>
<?php echo $footer; ?>