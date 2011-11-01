<?php
	/**
	 * 微博列表包含<ul>
	 * @param $list array 微博数组
	 */
if(!is_array($list) || empty($list)){
?>
	<div class="int-box ico-load-fail"><?php LO('modules__feedList__emptyTip');?></div>
<?php
}else{
	if(isset($show_delete_link) && true == $show_delete_link){
		$show_delete_link = true;
	}else{
		$show_delete_link = false;
	}
?>
<div>
<ul id="xwb_weibo_list_ct">

<?php
	/// 过滤微博
	$list = F('weibo_filter', $list);
	foreach ($list as $wb) {	/// 过滤掉过敏的原创微博
		if ((isset($wb['filter_state']) && !empty($wb['filter_state'])) || (isset($wb['user']['filter_state']) && !empty($wb['user']['filter_state']))) {
			continue;	
		}
		
		if ( !empty($wb['deleted']) ) {	// 忽略被删除的微博
			continue;
		}
	
		//是否显示用户头像, 0 不显示1 显示用户头像
		$wb['header'] = isset($header) ? $header: 1;
		$wb['uid'] 	  = USER::uid();
		$wb['author'] = isset($author) ? $author : TRUE;
		/// 待审核的微博
		if (isset($wb['xwb_weibo_verify']) && $wb['xwb_weibo_verify']) {
			if (isset($wb['xwb_picid']) && $wb['xwb_picid']) {
				$rel = 'w:'.$wb['id'].',v:1,p:'.$wb['xwb_picid'];
			} else {
				$rel = 'w:'.$wb['id'].',v:1';
			}
		} else {
			$rel = 'w:'.$wb['id'];
		}

		$wb['show_delete_link'] = $show_delete_link;
		echo '<li rel="'.$rel.'">';
			TPL::module('feed', $wb);
		echo '</li>';
	}
}
?>
</ul>
</div>
