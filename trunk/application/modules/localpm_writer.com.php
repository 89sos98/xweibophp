<?php

require_once dirname(__FILE__). '/localpm_reader.com.php';

/**
 * 本地私信数据库操作模型（写入模型）
 * 如果要包含前置检查等等，请使用pplication/class/localpm_front类
 * @author yaoying<yaoying@staff.sina.com.cn>
 * @version $Id: localpm_writer.com.php 17950 2011-08-23 11:39:23Z yaoying $
 *
 */
class localpm_writer extends localpm_reader{
	
	function localpm_writer()
	{
		parent::__construct();
	}
	
	/**
	 * 写入一条本地私信（数据库整体写入接口）
	 * @param bigint $from_uid 哪个人发消息？
	 * @param bigint $to_uid 哪个人接收消息？
	 * @param string text
	 */
	function writeNew($from_uid, $to_uid, $text){
		if(!is_numeric($from_uid) || !is_numeric($to_uid) || $from_uid < 1 || $to_uid < 1 || empty($text)){
			return RST(null, 1010000, 'Parameter is illegal');
		}
		
		$iid = $this->pm_index_getiid($from_uid, $to_uid);
		if($iid['rst'] < 1){
			$iid = 0;
		}else{
			$iid = $iid['rst'];
		}
		
		$time = APP_LOCAL_TIMESTAMP;
		
		if($iid == 0){
			$iid = $this->pm_index_create_iid($from_uid, $to_uid);
			if(!isset($iid['rst']) || $iid['rst'] < 1){
				return RST(null, -2, 'CAN NOT CREATE IID IN LOCAL_PM_INDEX');
			}
			$iid = $iid['rst'];
		}
		
		$data = array(
			'iid' => $iid,
			'sender_id' => $from_uid,
			'recipient_id' => $to_uid,
			'created_at' => $time,
			'text' => $this->db->escape($text),
		);
		
		$pm_id = $this->pm_content_insert($data);
		
		if(!isset($pm_id['rst']) || $pm_id['rst'] < 1){
			return RST(null, -3, 'CAN NOT CREATE ID IN LOCAL_PM_CONTENT');
		}
		$pm_id = $pm_id['rst'];
		
		$this->pm_index_user_increment_unread($from_uid, $iid, $time, 0, 1, $pm_id, serialize($data));
		$this->pm_index_user_increment_unread($to_uid, $iid, $time, 1, 1, $pm_id, serialize($data));
		
		return RST(true);
	}
	
	/**
	 * 在pm_content中，依据私信id，删除一条本地私信
	 * @param bigint $iid
	 * @param bigint $sina_uid 当传入次数值时，表示由mysql确认该私信是否该sina_uid可删除
	 * @return RST_Array
	 */
	function pm_content_deleteByid($id, $sina_uid = 0){
		$id = intval($id);
		if($id < 1){
			return RST(0);
		}
		
		$sql = 'DELETE FROM '. $this->db->getTable($this->tb_pm_content).
				" WHERE `id`='{$id}' ";
		if(is_numeric($sina_uid) && $sina_uid >= 1){
			$sql .= " AND (`sender_id` = '{$sina_uid}' or `recipient_id` = '{$sina_uid}') ";
		}
		
		$this->db->execute($sql);
		return RST($this->db->getAffectedRows());
		
	}
	
	
	/**
	 * 在pm_content中，依据私信索引iid，删除一组本地私信
	 * @param int $iid
	 * @param bigint $sina_uid 当传入此数值时，表示只删除被last_del_uid标记过并等于$sina_uid的私信
	 * @return RST_Array
	 */
	function pm_content_deleteByiid($iid, $sina_uid = 0){
		$iid = intval($iid);
		if($iid < 1){
			return RST(0);
		}
		
		$sql = 'DELETE FROM '. $this->db->getTable($this->tb_pm_content).
				" WHERE `iid`='{$iid}' ";
		if(is_numeric($sina_uid) && $sina_uid > 1){
			$sina_uid = $this->db->escape($sina_uid);
			$sql .= " AND `last_del_uid` = '{$sina_uid}' ";
		}
		
		$this->db->execute($sql);
		return RST($this->db->getAffectedRows());
		
	}	
	
	/**
	 * 创建一个iid
	 * @param bigint $from_uid
	 * @param bigint $to_uid
	 */
	function pm_index_create_iid($from_uid, $to_uid){
		$data = array(
			'actors' => $this->pm_index_create_format_actors($from_uid, $to_uid),
		);
		return RST($this->db->save($data, '', $this->tb_pm_index));
	}
	
	/**
	 * 更新本地私信集合索引表（pm_index）信息
	 * @param $iid
	 * @param $data
	 * @return RST_Array
	 */
	function pm_index_update_iid($iid, $data = array()){
		return RST($this->db->save($data, $iid, $this->tb_pm_index, 'iid'));
	}
	
	/**
	 * 更新本地私信集合索引表（pm_index）信息
	 * @param $iid
	 * @param $data
	 * @return RST_Array
	 */
	function pm_index_delete_iid($iid){
		return RST($this->db->delete($iid, $this->tb_pm_index, 'iid'));
	}
	
	/**
	 * 增加或者减少本地私信集合索引表（pm_index）的未读数，顺带更新其它内容
	 * @param unknown_type $increment
	 * @param unknown_type $iid
	 * @param unknown_type $actors
	 * @param array $otherdata
	 */
	function pm_index_increment_total_number($increment, $iid = null, $actors = null, $otherdata = array()){
		$increment = intval($increment);
		if($increment == 0){
			return RST(0);
		}
		$iid = abs(intval($iid));
		if($iid < 1 && empty($actors)){
			return RST(0);
		}
		
		if($iid > 0){
			$condition = " WHERE `iid` = '{$iid}'";
		}else{
			$actors = $this->db->escape($actors);
			$condition = " WHERE `actors` = '{$actors}'";
		}
		
		$add = '';
		if(!empty($otherdata)){
			foreach($otherdata as $k => $v){
				$add .= '`'. $this->db->escape($k). "` = '". $this->db->escape($v). "',";
			}
		}
		
		$sql = 'UPDATE '. $this->db->getTable($this->tb_pm_index). 
			' SET '. $add. " `total_number` = `total_number` + '{$increment}' {$condition}";
		
		$this->db->execute($sql);
		return RST($this->db->getAffectedRows());
	}
	
	/**
	 * 在pm_content中插入一条私信数据
	 * @param array $data
	 */
	function pm_content_insert($data){
		return RST($this->db->save($data, '', $this->tb_pm_content));
	}
	
	/**
	 * 在pm_content中更新一条私信数据
	 * @param array $data
	 */
	function pm_content_update($id, $data){
		return RST($this->db->save($data, $id, $this->tb_pm_content, 'id'));
	}
	
	/**
	 * 在pm_content中批量标记last_del_uid为指定的sina_uid（即标记指定的私信集合id被某人批量删除；前提：last_del_uid为0）
	 * @param int $iid
	 * @param bigint $sina_uid
	 * @return RST_array RST体内为影响条数
	 */
	function pm_content_markDelByiid($iid, $sina_uid){
		$iid = intval($iid);
		if($iid < 1 || !is_numeric($sina_uid) || $sina_uid < 1){
			return RST(0);
		}
		$sina_uid = $this->db->escape($sina_uid);
		
		$sql = 'UPDATE '. $this->db->getTable($this->tb_pm_content).
				" SET `last_del_uid` = '{$sina_uid}' ". 
				"WHERE `iid`='{$iid}' AND `last_del_uid` = '0'";
		
		$this->db->execute($sql);
		return RST($this->db->getAffectedRows());
		
	}
	
	/**
	 * 在pm_content中对指定的iid标记已经被接收者阅读
	 * @param int $iid
	 * @param bigint $recipient_id 是否对接收者也作检查，默认不作检查
	 */
	function pm_content_mark_recipient_readed($iid, $recipient_id = 0){
		$iid = abs(intval($iid));
		if($iid < 1){
			return RST(0);
		}
		
		$condition = " WHERE `iid` = '{$iid}' AND `recipient_unread` = 1 ";
		$recipient_id = $this->db->escape($recipient_id);
		if(is_numeric($recipient_id) && $recipient_id > 0){
			$condition .= " AND `recipient_id` = '{$recipient_id}'";
		}
		
		$sql = 'UPDATE '. $this->db->getTable($this->tb_pm_content). 
			' SET `recipient_unread` = 0 '. $condition;
		
		$this->db->execute($sql);
		return RST($this->db->getAffectedRows());
		
	}
	
	/**
	 * 替换或者更新本地私信用户及未读数索引（pm_index_user）信息，以增加未读消息提醒
	 * @param bigint $sina_uid
	 * @param int $iid
	 * @param int $lasttime
	 * @param int $increment_unread
	 * @param int $increment_total
	 * @param int $last_id
	 * @param string $lastdata
	 * @return RST_array RST体包含替换结果：true或者false
	 */
	function pm_index_user_increment_unread($sina_uid, $iid, $lasttime, $increment_unread = 0, $increment_total = 0 , $last_id = 0, $lastdata = ''){
		$sina_uid = $this->db->escape($sina_uid);
		$iid = intval($iid);
		$last_id = intval($last_id);
		$lastdata = $this->db->escape($lastdata);
		$lasttime = intval($lasttime);
		$increment_unread = intval($increment_unread);
		$increment_total = intval($increment_total);
		if($sina_uid < 1 || $iid < 1){
			return RST(false);
		}
		$this->db->execute(
			'INSERT INTO '. $this->db->getTable($this->tb_pm_index_user).
			" (`sina_uid`, `iid`, `unread_count`, `total_number`, `lasttime`, `last_id`, `last_data`) VALUES ('{$sina_uid}', '{$iid}', '{$increment_unread}', '{$increment_total}','{$lasttime}', '{$last_id}', '{$lastdata}')".
			" ON DUPLICATE KEY UPDATE `unread_count` = `unread_count` + '{$increment_unread}', `total_number` = `total_number` + '{$increment_total}', `lasttime` = '{$lasttime}', `last_id` = '{$last_id}', `last_data` = '{$lastdata}'"
		);
		return RST(true);
	}
	
	/**
	 * 重置本地私信用户及未读数索引的某个用户所有未读数（pm_index_user）
	 * @param bigint $sina_uid
	 * @param int $iid
	 * @param int $increment
	 */
	function pm_index_user_reset_unread_all($sina_uid){
		$sina_uid = $this->db->escape($sina_uid);
		if($sina_uid < 1){
			return RST(0);
		}
		
		$this->db->execute(
			'UPDATE '. $this->db->getTable($this->tb_pm_index_user).
			" SET `unread_count` = 0 ".
			" WHERE `sina_uid` = '{$sina_uid}' AND `unread_count` > 0"
		);
		
		return RST($this->db->getAffectedRows());
	}	
	
	/**
	 * 增加或者减少本地私信用户及未读数和总数索引（pm_index_user）
	 * @param bigint $sina_uid
	 * @param int $iid
	 * @param int $increment_unread
	 * @param array $otherdata 其它数据
	 */
	function pm_index_user_update_unread($sina_uid, $iid, $increment_unread = 0, $increment_total = 0, $otherdata = array()){
		$sina_uid = $this->db->escape($sina_uid);
		$iid = intval($iid);
		$increment_unread = intval($increment_unread);
		$increment_total = intval($increment_total);
		if($sina_uid < 1 || $iid < 1){
			return RST(0);
		}
		
		$otherdata_string = '';
		foreach($otherdata as $k => $v){
			$otherdata_string .= '`'. $this->db->escape($k). "` = '". $this->db->escape($v). "',";
		}
		
		$this->db->execute(
			'UPDATE '. $this->db->getTable($this->tb_pm_index_user).
			" SET {$otherdata_string} `unread_count` = `unread_count` + '{$increment_unread}', `total_number` = `total_number` + '{$increment_total}' ".
			" WHERE `sina_uid` = '{$sina_uid}' AND `iid` = '{$iid}'"
		);
		
		return RST($this->db->getAffectedRows());
	}
	
	/**
	 * 更新本地私信用户及未读数索引（pm_index_user）
	 * @param bigint $sina_uid
	 * @param int $iid
	 * @param int $increment
	 */
	function pm_index_user_update($sina_uid, $iid, $data){
		$sina_uid = $this->db->escape($sina_uid);
		$iid = intval($iid);
		if($sina_uid < 1 || $iid < 1 || empty($data)){
			return RST(0);
		}
		
		$string = '';
		foreach($data as $k => $v){
			$string .= '`'. $this->db->escape($k). "` = '". $this->db->escape($v). "',";
		}
		$string = substr($string, 0, -1);
		
		$this->db->execute(
			'UPDATE '. $this->db->getTable($this->tb_pm_index_user).
			" SET {$string} ".
			" WHERE `sina_uid` = '{$sina_uid}' AND `iid` = '{$iid}'"
		);
		
		return RST($this->db->getAffectedRows());
	}
		
	
	/**
	 * 删除某个用户的本地私信用户及未读数索引（pm_index_user）
	 * @param int $iid
	 * @param bigint $sina_uid_1
	 * @param bigint $sina_uid_2
	 * @return RST_array RST体内包含删除行数
	 */
	function pm_index_user_delete($iid, $sina_uid){
		$sina_uid = $this->db->escape($sina_uid);
		$iid = intval($iid);
		if($sina_uid < 1 || $iid < 1){
			return RST(0);
		}
		
		$this->db->execute(
			'DELETE FROM '. $this->db->getTable($this->tb_pm_index_user).
			" WHERE `sina_uid` = '{$sina_uid}' AND `iid` = '{$iid}'"
		);
		
		return RST($this->db->getAffectedRows());
	}	
	
}