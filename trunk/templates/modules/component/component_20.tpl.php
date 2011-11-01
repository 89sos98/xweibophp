<?php 
	/**
	 * 专题描述
	 * @version $Id$
	 */
	if(!defined('IN_APPLICATION')){
		exit('ACCESS DENIED!');
	}
	$page_id = intval(V('g:page_id'));
	$navId_id = intval(V('g:navId'));
	$route = APP::getRequestRoute();
	$zhuanti_url = W_BASE_HTTP.URL($route, 'page_id='. $page_id. '&navId='. $navId_id);
?>
<div class="topic-desc">
	<div class="hd">
		<h3><a href="#" class="txt" rel="e:sd,m:给大家推荐一个热门话题#<?php echo F('escape', $mod['title']);?>#！如果你也有兴趣，快来和我一起聊吧！<?php echo strtr($zhuanti_url, array(':'=>'\:')); ?>">推荐该话题给好友</a><?php echo F('escape', $mod['title']);?></h3>
	</div>
	<div class="bd">
		<?php print(APP::F('format_text_zhuanti', $mod['param']['desc']));?>
	</div>
</div>
