<?php
/*
 * 外部引入的相关参数
$param = array('title' => $title, //发布框上边的标题，默认是 '有什么新鲜事告诉大家？'
					'show_face'=>true, //是否显示表情按钮，默认是ture，显示，false不显示
					'show_upload_pic' => true, //是否显示上传图片按钮，默认是true，显示，false不显示 
					'show_video'=>true,//是否显示视频按钮，默认是true，显示，false不显示
					'show_music'=>true，//是否显示音乐按钮，默认是true，显示，false不显示
					'show_trends'=>true，//是否显示话题按钮，默认是true，显示，false不显示
					);
*/
// 1 使用新浪帐号登录，2 使用附属站帐号登录 3 可同时使用两种帐号登录
$login_way = V('-:sysConfig/login_way', 1)*1;
$sina_user_login_status = USER::isUserLogin();
$site_user_login_status = (bool)(USER::get('site_uid') > 0);
$input_req_login_tip = array('text_desc' => 'modules__input__inputReqGloalLogin', 'text_link' => 'modules__input__inputGoLogin');    //默认既未登录新浪微博又未登录站点帐号的提示
if($site_user_login_status && !$sina_user_login_status){
	$input_req_login_tip = array('text_desc' => 'modules__input__inputReqLogin', 'text_link' => 'modules__input__inputGoBind');    //未登录新浪微博但已登录站点帐号的提示
}
?>
<div class="post-box topic-post" id="publish_box">
	<?php
	//var_dump($_SERVER);
	$title = isset($title) ? $title : L('modules__input__inputTitle');
	$show_face = isset($show_face) ? $show_face : true;
	$show_upload_pic = isset($show_upload_pic) ? $show_upload_pic : true;
	$show_video = isset($show_video) ? $show_video : true;
	$show_music = isset($show_music) ? $show_music : true;
	$show_trends = isset($show_trends) ? $show_trends : true;
	$trends = isset($trends) ? '#'.$trends.'#' : '';
	?>
	<div class="key-tips" id="xwb_word_cal"><span>140</span></div>
	<div class="post-textarea" id="focusEl"><div class="inner"><textarea id="xwb_inputor"><?php echo $trends;?></textarea></div></div>
    <div class="add-area">
		<?php if ($show_face):?>
		<a class="ico-face" href="#" rel="e:ic"><?php LO('modules__input__inputFace');?></a>
		<?php endif;?>
		<?php if ($show_upload_pic):?>
			<span class="pic_uploading hidden" id="xwb_upload_tip"><?php LO('modules__input__inputUploading');?></span>
        <span class="pic-name hidden" id="xwb_photo_name"><a class="ico-close-btn" href="#" ></a></span>
        <div class="share-upload-pic" id="uploadBtn">
            <form class="upload-pic"  method="post"  enctype="multipart/form-data" id="xwb_post_form" action="" target="" id="xwb_imgupload_form">
                <input type="file" name="pic" id="xwb_img_file" value="" />
            </form>
			<a class="ico-pic" href="#" id="xwb_btn_img"><?php LO('modules__input__inputImage');?></a>
        </div>
        
		<?php endif;?>
		<?php if ($show_video):?>
			<a class="ico-video" href="#" id="xwb_btn_vd" rel="e:vd"><?php LO('modules__input__inputVideo');?></a>
		<?php endif;?>
    </div>
    <div class="share-btn <?php if (!$sina_user_login_status){?>share-btn-disable<?php }?>" rel="e:sd"></div>
	<div class="post-success hidden" id="xwb_succ_mask"><span class="icon-success"></span><?php LO('modules__input__inputSuccess');?></div>
	<div class="post-verify ico-verify hidden" id="xwb_veri_mask"><?php LO('modules__input__inputVerify');?></div>
	<div class="account-notbind ico-load-fail <?php if ($sina_user_login_status){?>hidden<?php }?>"><?php LO($input_req_login_tip['text_desc']);?><a href="#" class="" rel="e:lg"><?php LO($input_req_login_tip['text_link']);?></a></div>
</div>
