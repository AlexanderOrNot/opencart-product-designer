<?php
class ModelModuleProductDesigner extends Model {
	public function createDatabaseTables() {
		$prefix = DB_PREFIX;
		$sql = <<<EOF
		CREATE TABLE IF NOT EXISTS `{$prefix}product_option_designer` (
		  `product_id` int(11) NOT NULL,
		  `enable` tinyint(1) NOT NULL DEFAULT '0',
		  `add_text` tinyint(1) NOT NULL DEFAULT '0',
		  `add_images` tinyint(1) NOT NULL DEFAULT '0',
		  `add_custom_images` tinyint(1) NOT NULL DEFAULT '0',
		  `select_image_preset` tinyint(1) NOT NULL DEFAULT '0',
		  `upload_background` tinyint(1) NOT NULL DEFAULT '0',
		  KEY `product_id` (`product_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
        
		$sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('fonts_google','Quattrocento','Quattrocento')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('fonts_google','Trykker','Trykker')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('fonts_google','Roboto','Roboto')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('fonts_google','Hanalei Fill','Hanalei Fill')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('fonts_google','Flavors','Flavors')";
        $this->db->query($sql);
        
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('color_text','#fd0000','#fd0000')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('color_text','#0704ee','#0704ee')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('color_text','#e8f607','#e8f607')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('color_text','#28781f','#28781f')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('color_text','#f4ae07','#f4ae07')";
        $this->db->query($sql);
	}
	
	public function dropDatabaseTables() {
		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."product_option_designer`;";
		$this->db->query($sql);
		
		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."product_designer`;";
		$this->db->query($sql);
        
        $sql = "DELETE FROM `oc_setting` WHERE `group` = 'fonts_google'";
		$this->db->query($sql);
        
        $sql = "DELETE FROM `oc_setting` WHERE `group` = 'color_text'";
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