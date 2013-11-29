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
	</style>
</head>
<body>	
	<div class="col-left">
		<img src="http://placehold.it/600x856/000000/333333" />
	</div>
	<div class="col-right">
		<form method="post" action="">
			<?php if ($options) { ?>
              <div class="options">
                <h2><?php echo $text_option; ?></h2>
                <br />
                <?php foreach ($options as $option) { ?>
                <?php if ($option['type'] == 'select') { ?>
                <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                  <?php if ($option['required']) { ?>
                  <span class="required">*</span>
                  <?php } ?>
                  <b><?php echo $option['name']; ?>:</b><br />
                  <select name="option[<?php echo $option['product_option_id']; ?>]">
                    <option value=""><?php echo $text_select; ?></option>
                    <?php foreach ($option['option_value'] as $option_value) { ?>
                    <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                    </option>
                    <?php } ?>
                  </select>
                </div>
                <br />
                <?php } ?>
                <?php if ($option['type'] == 'radio') { ?>
                <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                  <?php if ($option['required']) { ?>
                  <span class="required">*</span>
                  <?php } ?>
                  <b><?php echo $option['name']; ?>:</b><br />
                  <?php foreach ($option['option_value'] as $option_value) { ?>
                  <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
                  <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label>
                  <br />
                  <?php } ?>
                </div>
                <br />
                <?php } ?>
                <?php if ($option['type'] == 'checkbox') { ?>
                <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                  <?php if ($option['required']) { ?>
                  <span class="required">*</span>
                  <?php } ?>
                  <b><?php echo $option['name']; ?>:</b><br />
                  <?php foreach ($option['option_value'] as $option_value) { ?>
                  <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
                  <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label>
                  <br />
                  <?php } ?>
                </div>
                <br />
                <?php } ?>
                <?php if ($option['type'] == 'image') { ?>
                <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                  <?php if ($option['required']) { ?>
                  <span class="required">*</span>
                  <?php } ?>
                  <b><?php echo $option['name']; ?>:</b><br />
                  <table class="option-image">
                    <?php foreach ($option['option_value'] as $option_value) { ?>
                    <tr>
                      <td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
                      <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
                      <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                          <?php if ($option_value['price']) { ?>
                          (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                          <?php } ?>
                        </label></td>
                    </tr>
                    <?php } ?>
                  </table>
                </div>
                <br />
                <?php } ?>
                <?php if ($option['type'] == 'text') { ?>
                <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                  <?php if ($option['required']) { ?>
                  <span class="required">*</span>
                  <?php } ?>
                  <b><?php echo $option['name']; ?>:</b><br />
                  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
                </div>
                <br />
                <?php } ?>
                <?php if ($option['type'] == 'textarea') { ?>
                <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                  <?php if ($option['required']) { ?>
                  <span class="required">*</span>
                  <?php } ?>
                  <b><?php echo $option['name']; ?>:</b><br />
                  <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
                </div>
                <br />
                <?php } ?>
                <?php if ($option['type'] == 'file') { ?>
                <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                  <?php if ($option['required']) { ?>
                  <span class="required">*</span>
                  <?php } ?>
                  <b><?php echo $option['name']; ?>:</b><br />
                  <input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>" class="button">
                  <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
                </div>
                <br />
                <?php } ?>
                <?php if ($option['type'] == 'date') { ?>
                <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                  <?php if ($option['required']) { ?>
                  <span class="required">*</span>
                  <?php } ?>
                  <b><?php echo $option['name']; ?>:</b><br />
                  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
                </div>
                <br />
                <?php } ?>
                <?php if ($option['type'] == 'datetime') { ?>
                <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                  <?php if ($option['required']) { ?>
                  <span class="required">*</span>
                  <?php } ?>
                  <b><?php echo $option['name']; ?>:</b><br />
                  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
                </div>
                <br />
                <?php } ?>
                <?php if ($option['type'] == 'time') { ?>
                <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                  <?php if ($option['required']) { ?>
                  <span class="required">*</span>
                  <?php } ?>
                  <b><?php echo $option['name']; ?>:</b><br />
                  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
                </div>
                <br />
                <?php } ?>
                <?php } ?>
              </div>
              <?php } ?>
              <div class="cart">
                <div><?php echo $text_qty; ?>
                  <input type="text" name="quantity" size="2" value="<?php echo $minimum; ?>" />
                  <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
                  &nbsp;
                  <input type="button" value="<?php echo $button_cart; ?>" id="button-cart" class="button" />
                </div>                
              </div>
		</form>
	</div>
<script type="text/javascript"><!--

$('#button-cart').bind('click', function() {    
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
		dataType: 'json',
		success: function(json) {	
		  	$.colorbox.close();
			$('.success, .warning, .attention, information, .error').remove();
			alert(json['success']);
			if (json['error']) {			 
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
                
                if (json['error']['profile']) {
                    $('select[name="profile_id"]').after('<span class="error">' + json['error']['profile'] + '</span>');
                }
			} 
			
			if (json['success']) {			 
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
				$('.success').fadeIn('slow');
					
				$('#cart-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});
});
function finish(){
	if(!confirm('<?php echo $text_All_text_image_converted; ?>'))
		return;
	var canvasData = pcpb.saveToImage();
	//split data to pieces with 90kb/piece
	var pieceCount = parseInt(canvasData.length/90000+1);
	var link = '<?php echo $link; ?>';
	var pieceIndex = 0;
	$('#spinner').show();
	sendData(pieceIndex, pieceCount, canvasData);
}
function sendData(index, count, data){
	var dataSend = data.substring(index*90000, (index+1)*90000);
	$.ajax({
		type: 'POST',
		url: 'index.php?route=pcpb/create/step3',
		dataType: 'json',
		data: {imageData: dataSend, imageIndex: index+1, imageCount: count},
		success: function(datas){
			console.log(datas);
			if(datas.errorCode != 0)
				alert(datas.errorMessage);
			else{
				index++;
				if(index<count)
					sendData(index,count,data);
				else{
					var token = datas.token;
					location.href='index.php?route=pcpb/create/finish&token=' + token + '&product_id=<?php echo $product_id ?>&product_option_price=<?php echo $product_option_price;?>&product_option_value_id=<?php echo $product_option_value_id; ?>&image_option_id=' + $('#image_option_id').val();						
				}
			}
		}
	})
}
//--></script>
</body>