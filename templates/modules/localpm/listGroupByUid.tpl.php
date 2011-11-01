<?php 
if(!defined('IN_APPLICATION')){
	exit('ACCESS DENIED!');
}
?>
<div class="title-box">
	<a class="btn-s2" href="#" rel="e:sdm"><span><?php LO('index__message__sendMessage');?></span></a>
	<h3><?php LO('modules__localpm/listGroupByUid__totalContact', $rst['total_number']);?>&nbsp;<a href="<?php echo URL('localpm.markAllReaded', 'verifyhash='. XSec::makeVerifyhash('localpm_markAllReaded')); ?>"><?php LO('modules__localpm/listGroupByUid__markAllReaded'); ?></a>	</h3>
</div>

<div class="message-list">

	<?php if(empty($rst['user_list'])): ?>
	<div class="default-tips">
		<div class="icon-tips"></div>
		<?php if (V('g:page', 1) > 1):?>
		<p><?php LO('modules__message__endPage');?></p>
		<?php else:?>
		<p><?php LO('modules__message__emptyTip');?></p>
		<?php endif;?>
	</div>
	<?php else: ?>

	<ul>
		<?php foreach($rst['user_list'] as $user): ?>
		<?php 
				if(!isset($userList[(string)$user['user_id']]['nickname'])){
					$username = APP::L('common__template__unknownuser');
				} else{
					$username = APP::F('escape' ,$userList[(string)$user['user_id']]['nickname']);
				}
				$profile_url = URL('ta',array('id' => $user['user_id']));
		?>
		<li>
			<div class="user-pic">
				<a href="<?php echo $profile_url;?>"><img src="<?php echo APP::F('profile_image_url', $user['user_id']);?>" alt=""></a>
				<?php if($user['unread_count'] > 0): ?> <span class="ico-new"></span><?php endif; ?>
			</div>
			<div class="msg-cont">
				<p class="cont">
				<?php if(!isset($user['pm']['sender_id'])): ?>
					<?php LO('modules__message__emptyTip'); ?>
				<?php else: ?>
					<?php if($curUserId == $user['pm']['sender_id']){LO('modules__localpm/listGroupByUid__sendTo');}?><a href="<?php echo $profile_url;?>" class="nick-name"><?php echo $username; ?></a>：<?php echo APP::F('format_text', APP::F('escape', $user['pm']['text'])); ?>
				<?php endif; ?>
				</p>
				<p class="info">
					<span>
						<a href="<?php echo URL('localpm.dialog', array('sina_uid' =>$user['user_id'])); ?>">
							<?php if($user['unread_count'] > 0){LO('modules__localpm/listGroupByUid__unreadPmNum', $user['unread_count']);}; ?>
							<?php LO('modules__localpm/listGroupByUid__totalPmNum', $user['total_number']);?>
						</a>
						|<a href="#" class="ico-reply" rel="e:rm,u:<?php echo $user['user_id'];?>,n:<?php echo $username;?>"><?php LO('modules__message__reply');?></a>
					</span>
					<em class="date"><?php echo APP::F('format_time', $user['lasttime']); ?></em>
				</p>
				<a href="#" class="ico-del" rel="e:dum,u:<?php echo $user['user_id'];?>"><?php LO('modules__message__delete');?></a>
			</div>
		</li>
		<?php endforeach; ?>
	</ul>
	
	<?php endif; ?>
	
	<!-- 分页 开始-->
	<?php TPL::module('page', array('list' => $rst['user_list'], 'limit' => $limit));?>
	<!-- 分页 结束-->
</div>

