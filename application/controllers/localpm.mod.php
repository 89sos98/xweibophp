<?php

class localpm_mod{
	
	function localpm_mod(){
		if(HAS_DIRECT_MESSAGES){
			APP::redirect('index.messages', 2);
		}
	}
	
	/**
	 * 页面一：显示当前登录用户和所有其它用户的本地私信集合（对话）
	 */
	function default_action(){
		TPL::display('localpm/listGroupByUid');
	}
	
	/**
	 * 页面二：显示当前登录用户与某一用户的所有本地私信
	 */
	function dialog(){
		$sina_uid = V('g:sina_uid');
		if(!is_numeric($sina_uid)){
			APP::tips( array('tpl'=>'e404', 'msg'=>L('controller__common__pageNotExist')) );
		}
		TPL::display('localpm/dialog');
	}
	
	/**
	 * 标记当前登录用户已经阅读所有私信
	 */
	function markAllReaded(){
		if(0 != XSec::checkSubmit('GET', array('add'=>'localpm_markAllReaded'))){
			exit('sec verify failure');
		}
		$srv = APP::O('localpm_service');
		$srv->resetUnread(USER::uid(), true);
		APP::redirect('localpm', 2);
	}
	
	/**
	 * 本地私信用户设定页面
	 */
	function setting(){
		TPL::display('localpm/setting');
	}
	
}