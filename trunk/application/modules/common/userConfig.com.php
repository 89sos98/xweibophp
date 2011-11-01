<?php
/**
 * @file			userConfig.com.php
 * @CopyRight		(C)1996-2099 SINA Inc.
 * @Project			Xweibo
 * @Author			heli <heli1@staff.sina.com.cn>
 * @Create Date:	2010-07-08
 * @Modified By:	heli/2010-11-15
 * @Brief			用户自定义配置项管理类
 */

class userConfig {
	
	var $_sql_result = array();
	
	var $_exist_sina_uid = array();
	
	///初始值 
	/// user_newfeed		有新微博显现方式
	/// user_newmsg			有未读新信息的显现方式
	/// user_page_wb		微博显示的条数 
	/// user_page_comment	评论显示的条数
	/// user_skin			用户皮肤设置
	/// new_followers		是否有新粉丝
	/// index_listId		我的首页的List ID
	/// new_local_pm		新本地私信数
	/// disallow_not_friend_local_pm    是否禁止非我关注的人发私信给我
	var $options = array(
						'user_newfeed' 		=>	'',
						'user_newmsg' 		=>	'',
						'user_newnotice'	=>	'1',
						'user_page_wb' 		=>	50,
						'user_page_comment' =>	20,
						'user_skin'			=>	'',
						'wap_font_size'		=>	'1',
						'wap_show_pic'		=>	'1',
						'wap_page_wb'		=>	'10',
						'new_followers'		=>	0,
						'index_listId'		=>  '',
						'new_local_pm' => 0,
						'disallow_not_friend_local_pm' => 0,
						'localpm_alert_new' => 1,
						);
	
	/**
	 * 保存用户配置信息
	 *
	 * @param int $sina_uid
	 * @param string $values
	 * @return bool|null
	 */
	function set($key = null, $value=null, $sina_uid=false)
	{
		if(!is_numeric($sina_uid)){
			$sina_uid 	= USER::uid(); 
		}
		
		//参数检查
		if(is_array($key)){
			foreach($key as $k => $v){
				if(!array_key_exists($k, $this->options)){
					return RST('', '2010001', 'Set the option does not exist'); 
				}
			}
		}else{
			if (!isset($this->options[$key])) {
				return RST('', '2010001', 'Set the option does not exist'); 
			}
		}
		
		//获取原有设置
		$user_configs 	= $this->get(null, $sina_uid);
		$user_configs	= (array)$user_configs['rst'];
		
		if(is_array($key)){
			$user_configs = array_merge($user_configs, $key);
		}else{
			$user_configs[$key] = $value;
		}
		
		$values = json_encode($user_configs);
		
		$sina_uid_string = (string)$sina_uid;
		$this->_sql_result[$sina_uid_string] = $user_configs;
		$data = array();
	   	$data['values'] = $values;
	   	
	   	$db = APP::ADP('db');
		if(!isset($this->_exist_sina_uid[$sina_uid_string])){
			$data['sina_uid'] = $sina_uid;
			$ret = $db->save($data, '', T_USER_CONFIG);
		}else{
			$ret = $db->save($data, $sina_uid, T_USER_CONFIG, 'sina_uid');
		}
		
		///删除缓存
		DD('common/userConfig.get');
		
		if ($ret === false) {
			return RST('', '2010002', 'Update configuration fails'); 
		}else{
			return RST(true);
		}	
		
	}
	
	/**
	 * 获取用户自定义配置信息
	 *
	 * @param int $sina_uid
	 * @return bool|null
	 */
	function get($key = null, $sina_uid=false, $useVarCache = true)
	{
		$sina_uid = $sina_uid===false ? USER::uid() : $sina_uid;
		if (empty($sina_uid) || !is_numeric($sina_uid)) {
			return RST($this->options); 
		}
		$sina_uid_string = (string)$sina_uid;
		
		if(false == $useVarCache || !isset($this->_exist_sina_uid[$sina_uid_string])){
			$db = APP :: ADP('db');
			$row = $db->query('SELECT * FROM ' . $db->getTable(T_USER_CONFIG) . " WHERE sina_uid = '{$sina_uid}'");
			$this->_sql_result[$sina_uid_string] = array();
			if (!empty($row)) {
				$this->_exist_sina_uid[$sina_uid_string] = 1;
				$values = $row[0]['values']; 
				$values = json_decode($values, true);
				if ($values === false || !is_array($values) ) {
					$this->_sql_result[$sina_uid_string] = array();
				}else{
					$this->_sql_result[$sina_uid_string] = $values;
				}
			} else {
				$this->_sql_result[$sina_uid_string] = $this->options;
			}
		}
		
		if ($key) {
			$kvalue = isset($this->_sql_result[$sina_uid_string][$key]) ? $this->_sql_result[$sina_uid_string][$key] : false;
			return RST($kvalue);	
		}
		return RST($this->_sql_result[$sina_uid_string]);
	}
	
	/**
	 * 清除保存在本类内部的信息
	 * @param bigint $sina_uid
	 */
	function clearVar($sina_uid){
		$sina_uid_string = (string)$sina_uid;
		unset($this->_sql_result[$sina_uid_string]);
		unset($this->_exist_sina_uid[$sina_uid_string]);
	}
	
}
