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
        <h2>PRODUCT OPTIONS</h2>
		<table class="form">
          <tr>
            <td><span class="required">*</span> Option to save customer's design</td>
            <td>
	            <select name="pd_option_save_design">
	            	<option>Your design</option>
	            </select>
                <!--<?php if ($error_option_background) { ?>
                	<span class="error"><?php echo $error_option_background; ?></span>
                <?php } ?> -->
			</td>
          </tr>
          <tr>
            <td><span class="required">*</span> Option to save customer's image</td>
            <td>
	            <select name="pd_option_save_image">
	            	<option>Your image</option>
	            </select>
			</td>
          </tr>
          <tr>
            <td><span class="required">*</span> Option to save customer's text</td>
            <td>
	            <select name="pd_option_save_text">
	            	<option>Your text</option>
	            </select>
			</td>
          </tr>
		  <tr>
            <td><span class="required">*</span> Option to save customer's selected font</td>
            <td>
	            <select name="pd_option_save_font">
	            	<option>Font</option>
	            </select>
			</td>
          </tr>
		  <tr>
            <td><span class="required">*</span> Option to save customer's selected text color</td>
            <td>
	            <select name="pd_option_save_text_color">
	            	<option>Text color</option>
	            </select>
			</td>
          </tr>
        </table>
		<h2>IMAGE</h2>		
		<table class="form">
          <tr>
            <td><span class="required">*</span> Max size of image uploađe by customer (in KB)</td>
            <td>
	            <input type="text" name="pd_max_size_upload" value=""/>
			</td>
          </tr>
        </table>
        <h2>TEXT</h2>		
		<table class="form">
          <tr>
              <td>Enable system fonts</td>
              <td>
              		<input type="radio" name="pd_system_font_enable" value="1" />
                	Yes
                	<input type="radio" name="pd_system_font_enable" value="0" />
                	No
              </td>
          </tr>
          <tr>
            <td>Google fonts</td>
            <td>
	            <input type="text" id="pd_google_font" value=""  style="display:inline-block;"/>
                <a onclick="addGoogleFonts();" class="button">Add</a>
            </td>            
          </tr>
          <tr>
            <td>Text color</td>
            <td>
	            <input type="text" id="pd_text_color" value=""  style="display:inline-block;"/>
                <a onclick="addGoogleFonts();" class="button">Add</a>
            </td> 
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>