<?php

/* LICENSE INFORMATION
 * kure is distributed under the terms of the GNU General Public License
 * (http://www.gnu.org/licenses/gpl.html).
 * kure Copyright 2007-2011 Ben Carlsson
 * 
 * This file is part of kure.
 * 
 * kure is free software: you can redistribute it and/or modify it under the terms of the 
 * GNU General Public License as published by the Free Software Foundation, either version
 * 3 of the License, or (at your option) any later version.
 * 
 * kure is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
 * PURPOSE.	See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along with kure.
 * If not, see <http://www.gnu.org/licenses/>.
 */

class Config {
	
	private $version;
	
	private $admin_password;
	private $show_admin_link;
	
	private $blog_name;
	private $blog_sub;
	
	private $template;
	
	private $posts_per_page;
	
	private $show_doc_dates;
	private $show_doc_page_dates;
	
	private $abc_posts;
	private $abc_docs;

	public function __construct() {
	}
	
	public function __get($variable) {
		return $this->$variable;
	}

	public function __set($variable, $value) {
		$this->$variable = $value;
	}
	
	// Writes the current configuration to file.
	// Returns true on success; false otherwise.
	public function save() {
		
		$write = '<?php' . "\n\n" . '// autogenerated by kure' . "\n\n";
		
		foreach(get_class_vars(self) as $key => $value) {
			
			$write .= '$this->set_' . $key . ' ';
			
			for($i = 0; $i < Engine::strlen_array($options); $i++) 
				$write .= ' ';
			
			if(is_string($value))
				$write .= '= \'' . $value . '\';' . "\n";
			elseif(is_bool($value))
				$write .= '= ' . ($value ? 'true' : 'false') . ';' . "\n";
			else
				$write .= '= ' . $value . ';' . "\n";
		
		}
		
		$write .= "\n";
		return (boolean)(file_put_contents('config.php', $write));
		
	}
	
	public function load() {
		
		include 'config.php';
		return $this;
		
	}
	
};

?>
