<div id="infomation" class="form-body">
	<div class="form-info">
		<p><?php LO('modules__localpm/setting__setWhoCanSend'); ?></p>
	</div>
	<form id="localpmForm" name="localpmForm">
		<div class="setting-box">
			<div class="row">
				<label><input type="radio" name="disallow" value="0" <?php if(0 == $disallow): ?>checked="checked"<?php endif; ?> /><?php LO('modules__localpm/setting__all'); ?></label>
			</div>
			<div class="row">
				<label><input type="radio" name="disallow" value="1" <?php if(1 == $disallow): ?>checked="checked"<?php endif; ?> /><?php LO('modules__localpm/setting__myattention'); ?></label>
			</div>
		</div>
		<div class="form-row submit-btn">
			<a id="trig" class="btn-s3" href="#"><span><?php LO('common__template__save'); ?></span></a>
		</div>
	</form>	
</div>