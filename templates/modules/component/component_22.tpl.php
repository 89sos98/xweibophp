<?php 
	/**
	 * 侧栏话题
	 * @version $Id$
	 */
	if(!defined('IN_APPLICATION')){
		exit('ACCESS DENIED!');
	}
?>
<div class="mod-aside explain">
    <div class="hd"><h3><?php echo F('escape', $mod['title']);?></h3></div>
	<div class="bd">
    	<div class="bg"></div>
        <div class="cont">
        	<?php print(APP::F('format_text_zhuanti', $mod['param']['desc']));?>
        </div>
    </div>
</div>
