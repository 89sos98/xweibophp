<?php 
	/**
	 * 侧栏视频
	 * @version $Id$
	 */
	if(!defined('IN_APPLICATION')){
		exit('ACCESS DENIED!');
	}
?>
<div class="mod-aside aside-video">
	<div class="hd">
		<h3><?php echo F('escape', $mod['title']);?></h3>
	</div>
	<div class="bd">
		<div class="video-cont">
			<?php print(isset($mod['param']['code'])? $mod['param']['code']: '');?>
		</div>
	</div>
</div>
