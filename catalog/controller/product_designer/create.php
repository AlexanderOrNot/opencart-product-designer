<?php 
class ControllerProductDesignerCreate extends Controller {
	private $error = array(); 
     
  	public function index() {
		$rand = $this->genRndNum(3);
		$token = time() . $rand;
		$productId = $this->request->get['product_id'];
		$this->redirect($this->url->link('product_designer/create/step1', 'token=' . $token . '&product_id=' . $productId));
  	}
	
	private function genRndNum($iLength = 8)
	{
		$sPassword = '';
		$sChars = "12345678901234567890";
		srand((double)microtime()*1000000);
		for($i = 0; $i < $iLength; $i++) {
			$x = mt_rand(0, strlen($sChars) -1);
			$sPassword .= $sChars{$x};
		}
		return $sPassword;
	}

	public function phpinfo(){
		phpinfo();
	}
	
	public function selectImage(){
		$this->language->load('module/product_designer');
		
    	$this->data['text_Present_Images'] = $this->language->get('text_Present_Images');
    	$this->data['text_Select'] = $this->language->get('text_Select');
    	$this->data['text_cancel_and_close'] = $this->language->get('text_cancel_and_close');
    	//$this->data['text_Present_Images'] = $this->language->get('text_Present_Images');
    	//$this->data['text_Present_Images'] = $this->language->get('text_Present_Images');

		$presentOptionId = $this->config->get('product_designer_option_preset');

		$this->load->model('product_designer/product_designer');
		$options = $this->model_product_designer_product_designer->getProductOptions($this->request->get['product_id']);

		$presentOptions = array();
		foreach ($options as $option) {
			if($option['option_id'] == $presentOptionId)
			{
				$presentOptions = $option['option_value'];
				break;
			}
		}

		/*function echoDbg( $what, $desc = '' )
		{
			if ( $desc )
				echo "<b>$desc:</b> ";
			echo "<pre>";
				print_r( $what );
			echo "</pre>\n";
		}

		echoDbg($presentOptions);exit();*/

		foreach ($presentOptions as $presentOption) {
			$imagePath = HTTP_SERVER . 'image/' . $presentOption['image'];
			$size = getimagesize($imagePath);
			$this->data['images'][] = array(
				'popup' => $imagePath,
				'thumb' => $imagePath,
				'width' => $size[0],
				'height' => $size[1],
				'name' => $presentOption['name'],
				'price' => floatval($presentOption['price']),
				'image_option_id' => $presentOption['product_option_value_id']
			);
		}

		$this->template = 'default/template/product_designer/selectImage.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function step1(){
		$this->language->load('module/product_designer');
		
    	$this->data['text_edit'] = $this->language->get('text_edit');
    	$this->data['text_copy'] = $this->language->get('text_copy');
    	$this->data['text_delete'] = $this->language->get('text_delete');
    	$this->data['text_edit_text'] = $this->language->get('text_edit_text');
    	$this->data['text_Edit_Background'] = $this->language->get('text_Edit_Background');
    	$this->data['text_content'] = $this->language->get('text_content');
    	$this->data['text_Font'] = $this->language->get('text_Font');
    	$this->data['text_Font_size'] = $this->language->get('text_Font_size');
    	$this->data['text_Color'] = $this->language->get('text_Color');
    	$this->data['text_Edit_Image'] = $this->language->get('text_Edit_Image');
    	$this->data['text_Upload'] = $this->language->get('text_Upload');
    	$this->data['text_Select_from_list'] = $this->language->get('text_Select_from_list');
    	$this->data['text_Flip'] = $this->language->get('text_Flip');
    	$this->data['text_Horizontal'] = $this->language->get('text_Horizontal');
    	$this->data['text_Vertical'] = $this->language->get('text_Vertical');
		$this->data['text_Border'] = $this->language->get('text_Border');
    	$this->data['text_Shadow'] = $this->language->get('text_Shadow');
		$this->data['text_Curve'] = $this->language->get('text_Curve');
		$this->data['text_Remove_Border'] = $this->language->get('text_Remove_Border');
    	$this->data['text_Remove_Shadow'] = $this->language->get('text_Remove_Shadow');
		$this->data['text_Remove_Curve'] = $this->language->get('text_Remove_Curve');
    	$this->data['text_cancel_and_close'] = $this->language->get('text_cancel_and_close');
    	$this->data['text_Back'] = $this->language->get('text_Back');
    	$this->data['text_Custom_your_product'] = $this->language->get('text_Custom_your_product');
    	$this->data['text_Add_Text'] = $this->language->get('text_Add_Text');
    	$this->data['text_Add_Image'] = $this->language->get('text_Add_Image');
    	$this->data['text_Change_Background'] = $this->language->get('text_Change_Background');
    	$this->data['text_Reset_Background'] = $this->language->get('text_Reset_Background');
    	$this->data['text_Finish'] = $this->language->get('text_Finish');
    	$this->data['text_All_text_image_cleared'] = $this->language->get('text_All_text_image_cleared');
    	$this->data['text_All_text_image_converted'] = $this->language->get('text_All_text_image_converted');
    	$this->data['text_Dimension_required'] = $this->language->get('text_Dimension_required');

        $this->load->model('setting/setting');
		$settings = $this->model_setting_setting->getSetting('product_designer');
		
        $this->load->model('catalog/product');
		$product_option_designers = $this->model_catalog_product->getProductOptionDesigner($this->request->get['product_id']);
            
        $this->data['product_option_designers'] = array();   
                        
		foreach ($product_option_designers as $product_option_designer) {
			if ($product_option_designer['frame_image'] && file_exists(DIR_IMAGE . $product_option_designer['frame_image'])) {
				$image = $product_option_designer['frame_image'];
			} else {
				$image = 'no_image.jpg';
			}
            $this->data['product_option_designers'][] = array(
				'frame_image'               => $image,
				'thumb'                     => $this->model_tool_image->resize($image, 100, 100),
				'enable'                    => $product_option_designer['enable'],
                'allow_adding_text'         => $product_option_designer['allow_adding_text'],
                'allow_text_effect_border'  => $product_option_designer['allow_text_effect_border'],
                'allow_text_effect_shadow'  => $product_option_designer['allow_text_effect_shadow'],
                'allow_text_effect_curve'   => $product_option_designer['allow_text_effect_curve'],
                'text_color'                => $product_option_designer['text_color']
			);
			
			$this->data['background'] = HTTP_SERVER . 'image/' . $image;
            $size = @getimagesize(DIR_IMAGE . $product_option_designer['frame_image']);
		}
		
		$this->data['product_id'] = $this->request->get['product_id'];
        
        $rand = $this->genRndNum(3);
		$token = time() . $rand;
		$product_id = $this->request->get['product_id'];
		$link = isset($this->request->post['link']) ? $this->request->post['link'] : '';
		
		$this->load->model('product_designer/product_designer');
		//$token = isset($this->request->post['link']) ? $this->request->post['link'] : time();
		if($this->model_product_designer_product_designer->getDataByToken($token)){
			$this->redirect($this->url->link('product_designer/create/step1', 'token=' . $token . '&product_id=' . $product_id . '&error=token existed'));
		}
        
		$this->load->model('setting/setting');
        
        $this->data['list_link_google_fonts_options'] = array();
        $this->data['list_link_google_fonts_options'] = explode(',',$this->config->get('pd_google_font'));
        
        $this->data['list_link_color_text_options'] = array();
        $this->data['list_link_color_text_options'] = explode(',',$this->config->get('pd_text_color'));
		
		if(!$size || !$product_id)
			die('error');
		$width = $size[0];
		$height = $size[1];
		
		$this->template = 'default/template/product_designer/step1.tpl';
		$this->data['width'] = $width;
		$this->data['height'] = $height;
		$this->data['product_id'] = $product_id;
		$this->data['link'] = $link;
		
		$this->response->setOutput($this->render());
	}
	
    public function step2(){
		$this->language->load('module/product_designer');        
        $this->language->load('product/product');
        
        $this->load->model('tool/image');
        $this->load->model('catalog/product');
        
        if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} else {
			$product_id = 0;
		}
		
		$this->load->model('catalog/product');
		
		$product_info = $this->model_catalog_product->getProduct($product_id);
        
        $this->data['text_select'] = $this->language->get('text_select');
        $this->data['text_option'] = $this->language->get('text_option');
		$this->data['text_qty'] = $this->language->get('text_qty');
		$this->data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
        $this->data['button_cart'] = $this->language->get('button_cart');
        $this->data['button_upload'] = $this->language->get('button_upload');   
        
        $this->data['options'] = array();
			
		foreach ($this->model_catalog_product->getProductOptions($product_id) as $option) { 
			if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox' || $option['type'] == 'image') { 
				$option_value_data = array();
				
				foreach ($option['option_value'] as $option_value) {
					if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
						if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
							$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$price = false;
						}
						
						$option_value_data[] = array(
							'product_option_value_id' => $option_value['product_option_value_id'],
							'option_value_id'         => $option_value['option_value_id'],
							'name'                    => $option_value['name'],
							'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
							'price'                   => $price,
							'price_prefix'            => $option_value['price_prefix']
						);
					}
				}
				
				$this->data['options'][] = array(
					'product_option_id' => $option['product_option_id'],
					'option_id'         => $option['option_id'],
					'name'              => $option['name'],
					'type'              => $option['type'],
					'option_value'      => $option_value_data,
					'required'          => $option['required']
				);					
			} elseif ($option['type'] == 'text' || $option['type'] == 'textarea' || $option['type'] == 'file' || $option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') {
				$this->data['options'][] = array(
					'product_option_id' => $option['product_option_id'],
					'option_id'         => $option['option_id'],
					'name'              => $option['name'],
					'type'              => $option['type'],
					'option_value'      => $option['option_value'],
					'required'          => $option['required']
				);						
			}
		}
        if ($product_info['minimum']) {
			$this->data['minimum'] = $product_info['minimum'];
		} else {
			$this->data['minimum'] = 1;
		}
        
		$this->template = 'default/template/product_designer/step2.tpl';
		
		$this->response->setOutput($this->render());
        
    }
	public function step3(){
		if(isset($this->request->post['imageData'])){
			$imageData = isset($this->session->data['imageData']) ? $this->session->data['imageData'] : '';
			$imageData .= $this->request->post['imageData'];

			$imageIndex = $this->request->post['imageIndex'];
			$imageCount = $this->request->post['imageCount'];
			if($imageIndex < $imageCount){
				$this->session->data['imageData'] = $imageData;
				$res = array(
					'errorCode' => 0
				);
				echo (json_encode($res));
				exit();
			}

			unset($this->session->data['imageData']);

			//$imageData = $this->request->post['imageData'];
			$filteredData=substr($imageData, strpos($imageData, ",")+1);
			$unencodedData=base64_decode($filteredData);
			$fileName = time() . '.png';
			
			$mainDir = $this->config->get('product_designer_path_folder_save_temprarily');
			if(!$mainDir || $mainDir == '' || !is_writable(DIR_IMAGE . $mainDir))
				$mainDir = 'product_designer/temp/';
			
			$imagePath = DIR_IMAGE . $mainDir . $fileName;
			$fp = fopen($imagePath , 'wb');
			fwrite($fp, $unencodedData);
			fclose($fp);
			
			$token = time();
			$content = HTTP_SERVER . 'image/' . $mainDir . $fileName;
			$this->load->model('product_designer/product_designer');
			$id = $this->model_product_designer_product_designer->insertImage($token, $content);
			
			if($id > 0){
				$res = array(
					'errorCode' => 0,
					'token' => $token
				);
				echo (json_encode($res));
				exit();
			}
		}
		$res = array(
			'errorCode' => 1,
			'errorMessage' => 'save fail'
		);
		echo (json_encode($res));
		exit();
		
	}
	
	public function finish(){
		$this->template = 'default/template/product_designer/finish.tpl';
		$token = isset($this->request->get['token'])?$this->request->get['token']:null;
		$product_id = isset($this->request->get['product_id'])?$this->request->get['product_id']:null;
		$product_option_value_id = isset($this->request->get['product_option_value_id'])?$this->request->get['product_option_value_id']:null;
		$image_option_id = isset($this->request->get['image_option_id'])?$this->request->get['image_option_id']:null;
		$product_option_price = isset($this->request->get['product_option_price'])?$this->request->get['product_option_price']:null;
		if(!$token || !$product_id)
			die('no token found');
			
		$this->load->model('product_designer/product_designer');
		$data = $this->model_product_designer_product_designer->getDataByToken($token);
		$this->data['image_link'] = $data['content'];
		$this->data['view_link'] = $this->url->link('product_designer/view', 'token=' . $token);
		$this->data['product_option_value_id'] = $product_option_value_id;
		$this->data['image_option_id'] = $image_option_id;
		$this->data['product_option_price'] = $product_option_price;

		$this->load->model('catalog/product');
		
		$product_info = $this->model_catalog_product->getProduct($product_id);

		$product_price = floatval($product_info['special']) > 0 ?  $product_info['special']: $product_info['price'];
		$product_price = floatval($product_price) + floatval($product_option_price);
		$this->data['total_price'] = $this->currency->format($this->tax->calculate($product_price, $product_info['tax_class_id'], $this->config->get('config_tax')));

		if (!$this->session->data['product_designer'])
			$this->session->data['product_designer'] = array();
		$this->session->data['product_designer'][$product_id] = array(
			'url' => $this->url->link('product_designer/view', 'token=' . $token),
			'product_option_value_id' => $product_option_value_id,
			'image_option_id' => $image_option_id,
			'token' => $token,
			'product_option_price' => $product_option_price,
			'total_price' => $this->data['total_price']

		);
		$this->response->setOutput($this->render());
	}
	
	function echoDbg( $what, $desc = '' )
	{
		if ( $desc )
			echo "<b>$desc:</b> ";
		echo "<pre>";
			print_r( $what );
		echo "</pre>\n";
	}
}
?>