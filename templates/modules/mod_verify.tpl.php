<div class="verify-con">
	<div class="title-box">
		<h3><?php LO('modules__mod_verify__whatis');?></h3>
	</div>
	<p><?php LO('modules__mod_verify__description',V('-:sysConfig/authen_small_icon'), V('-:sysConfig/site_name'));?></p>
	<div class="title-box">
		<h3><?php LO('modules__mod_verify__howto')?></h3>
	</div>
	<p><?php LO('modules__mod_verify__mailto', V('-:sysConfig/authen_request_email') ? '<a href="mailto:'. V('-:sysConfig/authen_request_email').'">' . V('-:sysConfig/authen_request_email').'</a>' :L('modules__mod_verify_admin'));?></p>
	<?php LO('modules__mod_verify__msg',  V('-:sysConfig/site_name'));?>
</div>
