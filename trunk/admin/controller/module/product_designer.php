<?php

class ControllerModuleProductDesigner extends Controller {
    private $error = array(); 
	 
	public function index() {
	    $this->language->load('module/product_designer');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            echo $this->request->post['pd_text_color'];
            print($this->request->post['pd_text_color']);
            break;
			$this->model_setting_setting->editSetting('pd', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->load->model('catalog/option');
		$options = $this->model_catalog_option->getOptions();
		$files = array();
		$texts = array();
        $text_font_colors = array();
		foreach($options as $option)
		{
			if($option['type'] == 'file'){
				$files[$option['option_id']] = $option['name'];
			}
			if($option['type'] == 'text'){
				$text_font_colors[$option['option_id']] = $option['name'];
			}
            if($option['type'] == 'textarea'){
				$texts[$option['option_id']] = $option['name'];
			}
		}
		$this->data['list_save_design_options'] = $files;
		$this->data['list_save_image_options'] = $files;
		$this->data['list_save_text_options'] = $texts;
        $this->data['list_save_font_options'] = $text_font_colors;
        $this->data['list_save_text_color_options'] = $text_font_colors;
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_product_options'] = $this->language->get('text_product_options');
		$this->data['text_option_save_design'] = $this->language->get('text_option_save_design');
		$this->data['text_option_save_image'] = $this->language->get('text_option_save_image');
		$this->data['text_option_save_text'] = $this->language->get('text_option_save_text');		
		$this->data['text_option_save_font'] = $this->language->get('text_option_save_font');
		$this->data['text_option_save_text_color'] = $this->language->get('text_option_save_text_color');
        
        $this->data['text_size'] = $this->language->get('text_size');
        $this->data['text_max_size_upload'] = $this->language->get('text_max_size_upload');
		
        $this->data['text_text'] = $this->language->get('text_text');
		$this->data['text_enable_system_fonts'] = $this->language->get('text_enable_system_fonts');
        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');
        
        $this->data['text_add_link_google_fonts'] = $this->language->get('text_add_link_google_fonts');
        $this->data['text_add_link'] = $this->language->get('text_add_link');
        $this->data['text_add_color_text'] = $this->language->get('text_add_color_text');
        $this->data['text_add_color'] = $this->language->get('text_add_color');
        
		$this->data['text_module'] = $this->language->get('text_module');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['error_option_save_design'])) {
			$this->data['error_option_save_design'] = $this->error['error_option_save_design'];
		} else {
			$this->data['error_option_save_design'] = '';
		}
		
		if (isset($this->error['error_option_save_image'])) {
			$this->data['error_option_save_image'] = $this->error['error_option_save_image'];
		} else {
			$this->data['error_option_save_image'] = '';
		}
		
		if (isset($this->error['error_option_save_text'])) {
			$this->data['error_option_save_text'] = $this->error['error_option_save_text'];
		} else {
			$this->data['error_option_save_text'] = '';
		}
		
    	if (isset($this->error['error_option_save_font'])) {
			$this->data['error_option_save_font'] = $this->error['error_option_save_font'];
		} else {
			$this->data['error_option_save_font'] = '';
		}
        
    	if (isset($this->error['error_option_save_text_color'])) {
			$this->data['error_option_save_text_color'] = $this->error['error_option_save_text_color'];
		} else {
			$this->data['error_option_save_text_color'] = '';
		}
        
		if (isset($this->error['error_max_size_upload'])) {
			$this->data['error_max_size_upload'] = $this->error['error_max_size_upload'];
		} else {
			$this->data['error_max_size_upload'] = '';
		}
		
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/product_designer', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
   		
		if (isset($this->request->post['pd_option_save_design'])) {
			$this->data['pd_option_save_design'] = $this->request->post['pd_option_save_design'];
		} else {
			$this->data['pd_option_save_design'] = $this->config->get('pd_option_save_design');
		}
		
		if (isset($this->request->post['pd_option_save_image'])) {
			$this->data['pd_option_save_image'] = $this->request->post['pd_option_save_image'];
		} else {
			$this->data['pd_option_save_image'] = $this->config->get('pd_option_save_image');
		}
		
		if (isset($this->request->post['pd_option_save_text'])) {
			$this->data['pd_option_save_text'] = $this->request->post['pd_option_save_text'];
		} else {
			$this->data['pd_option_save_text'] = $this->config->get('pd_option_save_text');
		}
		
        if (isset($this->request->post['pd_option_save_font'])) {
			$this->data['pd_option_save_font'] = $this->request->post['pd_option_save_font'];
		} else {
			$this->data['pd_option_save_font'] = $this->config->get('pd_option_save_font');
		}
        
        if (isset($this->request->post['pd_option_save_text_color'])) {
			$this->data['pd_option_save_text_color'] = $this->request->post['pd_option_save_text_color'];
		} else {
			$this->data['pd_option_save_text_color'] = $this->config->get('pd_option_save_text_color');
		}
        
        if (isset($this->request->post['pd_max_size_upload'])) {
			$this->data['pd_max_size_upload'] = $this->request->post['pd_max_size_upload'];
		} else {
			$this->data['pd_max_size_upload'] = $this->config->get('pd_max_size_upload');
		}
        
        if (isset($this->request->post['pd_system_font_enable'])) {
			$this->data['pd_system_font_enable'] = ($this->request->post['pd_system_font_enable'] == 1) ? true : false;
		} else {
			$this->data['pd_system_font_enable'] = ($this->config->get('pd_system_font_enable') == 1) ? true : false;
		}
        
        $list_fonts_google = $this->model_setting_setting->getSetting('fonts_google');
        
        foreach ($list_fonts_google as $key=>$name){
            $this->data['list_link_google_fonts_options'][] = array(
                'key'     =>      $key,
                'product_designer_fonts_google'     =>      $name
            );    
        }
        
        $list_color_text = $this->model_setting_setting->getSetting('color_text');
        
        foreach ($list_color_text as $key=>$name){
            $this->data['list_link_color_text_options'][] = array(
                'key'     =>      $key,
                'product_designer_color_text'     =>      $name
            );    
        }
        		
        $this->data['token'] = $this->session->data['token'];
		
		$this->data['action'] = $this->url->link('module/product_designer', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->template = 'module/product_designer.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	public function install()
	{
		$this->load->model('module/product_designer');
		$this->model_module_product_designer->createDatabaseTables();
	}
	public function uninstall()
	{
		$this->load->model('module/product_designer');
		$this->model_module_product_designer->dropDatabaseTables();
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/product_designer')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
			
		if (!$this->request->post['pd_option_save_design']) {
			$this->error['error_option_save_design'] = $this->language->get('error_option_save_design');
		}
		if (!$this->request->post['pd_option_save_image']) {
			$this->error['error_option_save_image'] = $this->language->get('error_option_save_image');
		}
		if (!$this->request->post['pd_option_save_text']) {
			$this->error['error_option_save_text'] = $this->language->get('error_option_save_text');
		}
        if (!$this->request->post['pd_option_save_font']) {
			$this->error['error_option_save_font'] = $this->language->get('error_option_save_font');
		}
        if (!$this->request->post['pd_option_save_text_color']) {
			$this->error['error_option_save_text_color'] = $this->language->get('error_option_save_text_color');
		}
		if (!$this->request->post['pd_max_size_upload']) {
			$this->error['error_max_size_upload'] = $this->language->get('error_max_size_upload');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}	
	}
	
	function echoDbg( $what, $desc = '' )
	{
		if ( $desc )
			echo "<b>$desc:</b> ";
		echo "<pre>";
			print_r( $what );
		echo "</pre>\n";
	}
    
    public function addGoogleFonts()
	{
	    $linkGoogleFonts = $this->request->post['fonts'];
        $file_headers = @get_headers($linkGoogleFonts);
        if($file_headers[0] == 'HTTP/1.1 404 Not Found') 
        {            
            $this->response->setOutput(json_encode(""));
        }
        else
        {   
            $arrLinkGoogleFonts = explode('=', $linkGoogleFonts);
    		$fontsPlus = $arrLinkGoogleFonts[1];
            $pos = strpos($linkGoogleFonts, "css?family");
            if($pos > 0 && $fontsPlus != null && $fontsPlus != "")
            {
                $fonts = str_replace("+", " ", $fontsPlus);
                
                $this->response->setOutput(json_encode($fonts));
            } 
            else
            {
                $this->response->setOutput(json_encode(""));
            }           
        }        
	}
    
    public function reLoadFonts()
	{
	   $json = array();
	    $list_fonts_google = $this->model_setting_setting->getSetting('fonts_google');
        
        foreach ($list_fonts_google as $key=>$name){
            $json = array(
                'key'     =>      $key,
                'product_designer_fonts_google'     =>      $name
            );    
        }
        
        $this->response->setOutput(json_encode($json));
	}
    
    public function removeGoogleFonts()
	{
	    $fonts = $this->request->post['fonts'];
        
		$this->load->model('module/product_designer');
		$this->model_module_product_designer->removeGoogleFonts($fonts);
        
        $this->response->setOutput(json_encode($fonts));
	}
    
    public function addColorText()
	{
	    $colorText = $this->request->post['color'];
        if($colorText != null && $colorText != "")
        {
            $color = str_replace(" ", "", $colorText);
    		$this->load->model('module/product_designer');
    		$this->model_module_product_designer->addColorText('color_text', $color);
            
            $this->response->setOutput(json_encode($color));
        } 
        else
        {
            $this->response->setOutput(json_encode(""));
        }    
	}
    
    public function removeColorText()
	{
	    $color = $this->request->post['color'];
        
		$this->load->model('module/product_designer');
		$this->model_module_product_designer->removeColorText($color);
        
        $this->response->setOutput(json_encode($color));
	}
}

?>