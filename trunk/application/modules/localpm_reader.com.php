<?php
/**
 * 本地私信数据库操作模型（读取模型）
 * 如果要包含前置检查等等，请使用application/class/localpm_front类
 * @author yaoying<yaoying@staff.sina.com.cn>
 * @version $Id: localpm_reader.com.php 17950 2011-08-23 11:39:23Z yaoying $
 *
 */
class localpm_reader{
	
	/**
	 * @var mysql_db
	 */
	var $db;
	
	//本地私信用户及未读数索引
	var $tb_pm_index_user = 'local_pm_index_user';
	
	//本地私信集合索引表
	var $tb_pm_index = 'local_pm_index';
	
	//本地私信内容
	var $tb_pm_content = 'local_pm_content';
	
	function __construct(){
		$this->localpm_reader();
	}
	
	function localpm_reader()
	{
		$this->db =& APP::ADP('db');
	}
	
	/**
	 * 在本地私信用户及未读数索引（pm_index_user）中获取指定用户的私信集合id，并按照往来的最新时间排序。
	 * @param bigint $sina_uid
	 * @param int $page
	 * @param int $count
	 * @param bool $join_pm_index 是否并表查询pm_index，以获取iid的信息？默认为否
	 * @return RST_array
	 */
	function pm_index_user_getListGroupByUid($sina_uid, $page = 1, $count = 50, $join_pm_index = false){
		if(!is_numeric($sina_uid) || $count < 1){
			return RST(array());
		}
		
		$count = intval($count);
		$limit_start = abs(intval($page) - 1) * $count;
		$sina_uid = $this->db->escape($sina_uid);
		
		if(true != $join_pm_index){
			$sql = 'SELECT * FROM '. $this->db->getTable($this->tb_pm_index_user). 
				" WHERE `sina_uid` = '{$sina_uid}'".
				" ORDER BY `lasttime` DESC LIMIT {$limit_start}, {$count}";
		}else{
			$sql = 'SELECT iu.*, i.actors FROM '. $this->db->getTable($this->tb_pm_index_user). ' iu'. 
				" LEFT JOIN ". $this->db->getTable($this->tb_pm_index). " i ON iu.iid = i.iid".
				" WHERE iu.`sina_uid` = '{$sina_uid}'".
				" ORDER BY iu.`lasttime` DESC LIMIT {$limit_start}, {$count}";
		}
		
		$iidList = $this->db->query($sql);
		
		if(!is_array($iidList) || empty($iidList)){
			return RST(array());
		}else{
			return RST($iidList);
		}
	}
	
	/**
	 * 在本地私信用户及未读数索引中获取一条记录
	 * @param bigint $sina_uid
	 * @param int $iid
	 */
	function pm_index_user_getByKey($sina_uid, $iid){
		if(!is_numeric($sina_uid) || !is_numeric($iid) || $sina_uid < 1 || $iid < 1){
			return RST(array());
		}
		
		$sina_uid = $this->db->escape($sina_uid);
		$iid = intval($iid);
		
		$sql = 'SELECT * FROM '. $this->db->getTable($this->tb_pm_index_user). 
				" WHERE `sina_uid` = '{$sina_uid}' AND `iid` = '{$iid}'".
				" LIMIT 0,1";
		$iidData = $this->db->getRow($sql);
		
		if(!is_array($iidData) || empty($iidData)){
			return RST(array());
		}else{
			return RST($iidData);
		}
	}
	
	/**
	 * 在本地私信用户及未读数索引中查询某些用户总共有多少条私信未读
	 * @param array $sina_uids
	 * @return array
	 */
	function pm_index_user_unread_sum($sina_uids){
		$condition = array();
		foreach((array)$sina_uids as $sina_uid){
			if(is_numeric($sina_uid)){
				$condition[] = "'". $this->db->escape($sina_uid). "'";
			}
		}
		if(empty($condition)){
			return RST(array());
		}
		
		$condition = implode(',', $condition);
		$sql = 'SELECT `sina_uid`, sum(`unread_count`) as `sum` FROM '. $this->db->getTable($this->tb_pm_index_user). 
				" WHERE `sina_uid` IN ({$condition}) GROUP BY `sina_uid`";
		$data = $this->db->query($sql);
		
		if(!is_array($data) || empty($data)){
			return RST(array());
		}else{
			return RST($data);
		}
	}
	
	/**
	 * 在本地私信用户及未读数索引（pm_index_user）中获取指定的一个用户一共有多少与多少个用户有对话
	 * @param bigint $sina_uid
	 * @return RST_array RST体内包含指定用户一共有多少个与其它用户的条对话
	 */
	function pm_index_user_countOneUser($sina_uid){
		if(!is_numeric($sina_uid)){
			return RST(0);
		}
		$sql = 'SELECT count(*) as `count` FROM '. $this->db->getTable($this->tb_pm_index_user). 
				" WHERE `sina_uid` = '{$sina_uid}'";
		$data = $this->db->getRow($sql);
		
		if(!isset($data['count'])){
			return RST(0);
		}else{
			return RST($data['count']);
		}
	}	
	
	/**
	 * 从本地私信集合索引表中获取私信集合id数据
	 * @param array $iids
	 * @return array
	 */
	function pm_index_getAll($iids){
		$string = '';
		foreach($iids as $k){
			if(is_numeric($k)){
				$string .= ("'{$k}',");
			}
		}
		
		$string = substr($string, 0, -1);
		if(empty($string)){
			return RST(array());
		}
		
		$sql = 'SELECT * FROM '. $this->db->getTable($this->tb_pm_index). 
				" WHERE `iid` IN ({$string})";
		$result = $this->db->query($sql);
		
		if(!is_array($result) || empty($result)){
			return RST(array());
		}else{
			return RST($result);
		}
		
	}

	/**
	 * 从本地私信集合索引表中获取一条私信集合id数据
	 * @param array $iids
	 * @return array
	 */
	function pm_index_get($iid){
		$iid = intval($iid);
		if($iid < 1){
			return RST(array());
		}
		
		$sql = 'SELECT * FROM '. $this->db->getTable($this->tb_pm_index). 
				" WHERE `iid` = '{$iid}'";
		$result = $this->db->getRow($sql);
		
		if(!is_array($result) || empty($result)){
			return RST(array());
		}else{
			return RST($result);
		}
		
	}	
	
	/**
	 * 创建pm_index中所需的actor格式
	 * @param bigint $sina_uid_1
	 * @param bigint $sina_uid_2
	 * @return string
	 */
	function pm_index_create_format_actors($sina_uid_1,$sina_uid_2){
		if($sina_uid_1 < $sina_uid_2){
			return $this->db->escape($sina_uid_1. '#'. $sina_uid_2);
		}else{
			return $this->db->escape($sina_uid_2. '#'. $sina_uid_1);
		}
	}
	
	/**
	 * 获取两个指定用户的唯一私信集合id
	 * @param bigint $sina_uid_1
	 * @param bigint $sina_uid_2
	 * @return int iid值，若不存在，则返回0
	 */
	function pm_index_getiid($sina_uid_1, $sina_uid_2){
		if(!is_numeric($sina_uid_1) || !is_numeric($sina_uid_2) || $sina_uid_1 < 1 || $sina_uid_2 < 1){
			return RST(0);
		}
		$condition = $this->pm_index_create_format_actors($sina_uid_1, $sina_uid_2);
		$sql = 'SELECT iid FROM '. $this->db->getTable($this->tb_pm_index).
				" WHERE actors='{$condition}' LIMIT 1";
		$result = $this->db->getRow($sql);
		if(!is_array($result) || !isset($result['iid']) || $result['iid'] < 1){
			return RST(0);
		}else{
			return RST($result['iid']);
		}
	}
	
	/**
	 * 依据iid，获取具体的本地私信列表
	 * 并按照发布时间排序
	 * @param bigint $iid
	 * @param int $page
	 * @param int $count
	 * @param bigint $hide_delete_uid 不查询在指定iid中，被指定用户删除的本地私信
	 * @return array
	 */
	function pm_content_getAllByiid($iid, $page = 1, $count = 50, $hide_delete_uid = 0){
		if(!is_numeric($iid) || $iid < 1 || $count < 1){
			return RST(array());
		}
		
		$iid = intval($iid);
		$count = intval($count);
		$limit_start = abs(intval($page) - 1) * $count;
		
		$sqladd = '';
		if(is_numeric($hide_delete_uid) && $hide_delete_uid > 0){
			$hide_delete_uid = $this->db->escape($hide_delete_uid);
			$sqladd = " AND `last_del_uid` !=  '{$hide_delete_uid}' ";
		}
		
		$sql = 'SELECT * FROM '. $this->db->getTable($this->tb_pm_content).
				" WHERE iid='{$iid}' {$sqladd} ORDER BY `created_at` DESC LIMIT {$limit_start}, {$count}";		
		$result = $this->db->query($sql);
		if(!is_array($result)){
			return RST(array());
		}else{
			return RST($result);
		}
	}
	
	/**
	 * 依据私信id，获取一条本地私信
	 * @param bigint $iid
	 * @param bigint $sina_uid 当传入次数值时，表示由mysql确认该私信是否该sina_uid可读取
	 * @return RST_Array
	 */
	function pm_content_get($id, $sina_uid = 0){
		$id = intval($id);
		if($id < 1){
			return RST(array());
		}
		
		$sql = 'SELECT * FROM '. $this->db->getTable($this->tb_pm_content).
				" WHERE `id`='{$id}' ";
		if(is_numeric($sina_uid) && $sina_uid >= 1){
			$sql .= " AND (`sender_id` = '{$sina_uid}' or `recipient_id` = '{$sina_uid}') ";
		}
		
		$result = $this->db->getRow($sql);
		if(!is_array($result)){
			return RST(array());
		}else{
			return RST($result);
		}
	}	

}