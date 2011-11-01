<?php

class localpm_pls{
	
	var $srv = null;
	
	function localpm_pls(){
		$this->srv =& APP::O('localpm_service');
	}
	
	/**
	 * 本地私信第一个页面（列出该用户与所有微博的信息）
	 */
	function listGroupByUid(){
		//强制小黄标签上的未读数清零
		$new_local_pm = intval(V('-:userConfig/new_local_pm'));
		if(0 != $new_local_pm){
			DS('common/userConfig.set', null, 'new_local_pm', 0, USER::uid());
		}
		
		$page = intval(V('g:page', 1));
		$limit = 25;
		$res = $this->srv->listGroupByUid(USER::uid(), $page, $limit);
		
		//获取用户信息
		$userList = array();
		foreach($res['rst']['user_list'] as $user){
			$userList[] = $user['user_id'];
		}
		if(!empty($userList)){
			$dbuser = DS('mgr/userCom.getNicknameByUids', null, $userList);
			$userList = array();
			foreach($dbuser as $row){
				$userList[(string)$row['sina_uid']] = $row;
			}
		}
		
		TPL::module('localpm/listGroupByUid', array('rst'=>$res['rst'], 'page'=> $page, 'userList'=>$userList, 'curUserId' =>  USER::uid(), 'limit' => $limit));
		return array('cls'=>'localpm_list', 'rst'=>$res['rst'], 'userList'=>$userList);
	}
	
	/**
	 * 本地私信第二个页面（列出指定用户的私信对话页面）
	 * 如果该用户没有在T_USER表存在，则表示该用户已经被删除。此时也不会查询该用户的任何信息
	 */
	function dialog(){
		$result = array('user'=>array(), 'dialog'=>array());
		$sina_uid = V('g:sina_uid');
		$page = intval(V('g:page', 1));
		$limit = 30;
		
		if(is_numeric($sina_uid)){
			$userdata = DS('mgr/userCom.getByUid', null, $sina_uid);
			if(isset($userdata['sina_uid'])){
				$result['user']['sina_uid'] = $userdata['sina_uid'];
				$result['user']['nickname'] = $userdata['nickname'];
				$conversation = $this->srv->getConversation(USER::uid(), $sina_uid, $page, $limit);
				$result['dialog'] = $conversation['rst'];
				$this->_checkAndMarkReaded($result['dialog']['pms']);
			}
		}
		
		$result['page'] = $page;
		$result['limit'] = $limit;
		
		TPL::module('localpm/dialog', $result);
		$result['cls'] = 'localpm_dialog';
		return $result;
		
	}
	
	/**
	 * 检查当前对话是否有没有阅读的信息，并且进行标记已读操作
	 * @access protected
	 * @param array $pms
	 */
	function _checkAndMarkReaded($pms){
		//USER
		$uid = USER::uid();
		foreach($pms as $pm){
			if(1 == $pm['recipient_unread'] && $uid == $pm['recipient_id']){
				$this->srv->markRecipientHasReadByiid($pm['iid'], $uid);
				break;
			}
		}
	}
	
	/**
	 * 本地私信设定
	 */
	function setting(){
		$disallow_not_friend_local_pm = intval(V('-:userConfig/disallow_not_friend_local_pm')) == 0 ? 0 : 1;
		TPL::module('localpm/setting', array('disallow' => $disallow_not_friend_local_pm));
	}
	
}