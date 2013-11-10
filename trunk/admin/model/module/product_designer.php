<?php
class ModelModuleProductDesigner extends Model {
	public function createDatabaseTables() {
		$prefix = DB_PREFIX;
		$sql = <<<EOF
		CREATE TABLE IF NOT EXISTS `{$prefix}product_option_designer` (
		  `product_id` int(11) NOT NULL,
		  `enable` tinyint(1) NOT NULL DEFAULT '0',
		  `frame_image` nvarchar(225),
		  `allow_adding_text` tinyint(1) DEFAULT '0',
		  `allow_text_effect_border` tinyint(1) DEFAULT '0',
		  `allow_text_effect_shadow` tinyint(1) DEFAULT '0',
		  `allow_text_effect_curve` tinyint(1) DEFAULT '0',
          `text_color` tinyint(1) DEFAULT '0',
		  KEY `product_id` (`product_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
EOF;
		$this->db->query($sql);
		
		$sql = <<<EOF
		CREATE TABLE IF NOT EXISTS `{$prefix}product_designer` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `token` varchar(20) NOT NULL,
		  `content` text NOT NULL,
		  PRIMARY KEY (`id`),
		  UNIQUE KEY `token` (`token`)
		) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
				
EOF;
		$this->db->query($sql);
        
		$sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('product_designer','pd_google_font','Engagement,Damion,Oswald,Hanalei Fill,Flavors')";
        $this->db->query($sql);
                
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('product_designer','pd_text_color','#ac725e,#d06b64,#f83a22,#fa573c,#ff7537')";
        $this->db->query($sql);
	}
	
	public function dropDatabaseTables() {
		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."product_option_designer`;";
		$this->db->query($sql);
		
		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."product_designer`;";
		$this->db->query($sql);
        
        $sql = "DELETE FROM `".DB_PREFIX."setting` WHERE `group` = 'product_designer'";
		$this->db->query($sql);        
	}
	public function getProductOptionDesigner($product_id)
	{
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_designer WHERE product_id = '" . (int)$product_id . "'");
		return $query->row;
	}
    
    public function addGoogleFonts($group, $key, $store_id = 0) {		
		$this->db->query("INSERT INTO " . DB_PREFIX . "setting SET store_id = '" . (int)$store_id . "', `group` = '" . $this->db->escape($group) . "', `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape($key) . "'");
	}
    
    public function removeGoogleFonts($key, $store_id = 0) {		
		$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE store_id = '" . (int)$store_id . "' AND `key` = '" . $this->db->escape($key) . "'");
	}
    
    public function addColorText($group, $key, $store_id = 0) {		
		$this->db->query("INSERT INTO " . DB_PREFIX . "setting SET store_id = '" . (int)$store_id . "', `group` = '" . $this->db->escape($group) . "', `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape($key) . "'");
	}
    
    public function removeColorText($key, $store_id = 0) {		
		$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE store_id = '" . (int)$store_id . "' AND `key` = '" . $this->db->escape($key) . "'");
	}
}
?>