<?php 
if(!defined('IN_APPLICATION')){
	exit('ACCESS DENIED!');
}
$curUserId = USER::uid();
?>
<div id="xwb_myMsg" class="post-box msg-dialog">
	<!-- 超过300字时，class="key-tips out140" -->
	<div class="dialog-title">
		<a href="<?php echo URL('localpm') ?>" class="goback">&lt;&lt;<?php LO('modules__localpm/dialog__backToList'); ?></a>
		<?php if(empty($user)): ?>
		<span><?php LO('modules__localpm/dialog__userNotExist'); ?></span>
		<?php else: ?>
		<span><?php LO('modules__localpm/dialog__dialogBetweenMeAndPerson', APP::F('escape', $user['nickname']));?></span>
		<?php endif; ?>
	</div>
	
	<?php if(!empty($user)): ?>
	<div class="key-tips" id="word">您还可以输入<span>300</span>字</div>
	<div class="post-textarea post-focus"><div class="inner"><textarea id="content"></textarea></div></div>
	<div class="add-area">
		<a class="ico-face" href="javascrip:;" rel="e:ic">表情</a>
	</div>
	<div class="btn-send"><a href="#" class="btn-s1" rel="e:sd"><span>发送</span></a></div>
	<div class="post-success hidden"><span class="icon-success"></span>发送成功！</div>
	<div class="account-notbind ico-load-fail hidden">您需要绑定新浪微博帐号后才可以发布，<a href="#">现在就去绑定</a></div>
    <div class="post-verify ico-verify hidden">信息已进入审核中</div>
	<input id="sender" class="style-normal" type="hidden">
	<input id="uid" type="hidden" value="">
    <?php endif; ?>
</div>



<?php if(!empty($user)): ?>
<div class="message-list dialog-list">
	
	<?php if(empty($dialog['pms'])): ?>
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
		<?php foreach($dialog['pms'] as $pm): ?>
		<?php 
				if($curUserId == $pm['sender_id']){
					$sender_username = APP::L('common__template__me');
				}else{
					$sender_username = APP::F('escape' ,$user['nickname']);
				}
				$sender_profile_image_url = APP::F('profile_image_url', $pm['sender_id']);
				$sender_profile_url = URL('ta',array('id' => $pm['sender_id']));
		?>
		<li>
			<div class="user-pic">
				<a href="<?php echo $sender_profile_url; ?>"><img src="<?php echo $sender_profile_image_url; ?>" alt=""></a>
			</div>
			<div class="msg-cont <?php if($pm['sender_id'] == $curUserId): ?>my-cont<?php endif; ?>">
				<p class="cont"><?php echo $sender_username; ?>：<?php echo APP::F('format_text', APP::F('escape', $pm['text'])); ?>&nbsp;&nbsp;(<?php echo APP::F('format_time', $pm['created_at']); ?>)</p>
				<a href="#" class="ico-del" rel="e:dm,m:<?php echo $pm['id']?>"><?php LO('modules__message__delete');?></a>
				 <!-- 左边箭头 开始 -->
				<ul class="arrow left">
					<li class="a1"></li>
					<li class="a2"></li>
					<li class="a3"></li>
					<li class="a4"></li>
					<li class="a5"></li>
					<li class="a6"></li>
					<li class="a7"></li>
					<li class="a8"></li>
				</ul>
				 <!-- 左边箭头 结束 -->
			</div>
		</li>
		<?php endforeach; ?>
	</ul>
	<?php endif; ?>
	<!-- 分页 开始-->
	<?php TPL::module('page', array('list' => $dialog['pms'], 'limit' => $limit));?>
	<!-- 分页 结束-->
</div>
<?php endif; ?>