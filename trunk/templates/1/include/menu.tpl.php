        <div class="menu">
        	<ul  class="main-menu">
        	<?php 
        		$pageList = DR('PageModule.getPagelistByType');
				$navList  = DR('Nav.getNavList', FALSE, TRUE);
				$is_first = true;
				foreach ($navList as $id => $aNav)
				{
					if (!isset($aNav['data']) || $aNav['data']['in_use'] != '1') {continue;}
					$pageId  = $aNav['data']['page_id'];
					if ($pageId == '-1') {
						$pageUrl = $aNav['data']['url'];					
					} else {
						$p = array(
							'page_id' =>$pageId,
							'nav_id' => $aNav['data']['id']
						);
						$pageUrl = isset($pageList[$pageId]['url']) ? URL($pageList[$pageId]['url'], $p) : '#';
					}
					//$target  = $aNav['data']['is_blank'] ? ' target="_blank" ' : '';
					if (1 == $id) {	// 微博广场  ?>
						<li class="menu-pub <?php echo $is_first?'class="menu-first"':''; if (V('g:nav_id')==$aNav['data']['id']) { echo ' menu-custom';}?>"><a hideFocus="true" <?php echo $target; ?> href="<?php echo $pageUrl;?>"><?php echo $aNav['data']['name']; ?></a>
					
					<?php } elseif (2 == $id) { // 名人堂 ?>
						<li class="menu-user <?php echo $is_first?'class="menu-first"':''; if (V('g:nav_id')==$aNav['data']['id']) { echo ' menu-custom';}?>"><a hideFocus="true" <?php echo $target; ?> href="<?php echo $pageUrl;?>"><?php echo $aNav['data']['name']; ?></a>
					
					<?php } elseif (3 == $id) { // 我的首页  ?>
						<li class="menu-home <?php echo $is_first?'class="menu-first"':'';if (V('g:nav_id')==$aNav['data']['id']) { echo ' menu-custom';}?>"><a hideFocus="true" <?php echo $target; ?> href="<?php echo $pageUrl; ?>"><?php echo $aNav['data']['name']; ?></a>
					
					<?php } elseif (4 == $id) { // 我的微博  ?>
						<li class="menu-weibo <?php echo $is_first?'menu-first':'';if (V('g:nav_id')==$aNav['data']['id']) { echo ' menu-custom';}?>"><a hideFocus="true"  <?php echo $target; ?> href="<?php echo $pageUrl;?>"><?php echo $aNav['data']['name']; ?></a>
					<?php } else { ?>
						<li  class="<?php echo $is_first?'menu-first':'';if (V('g:nav_id')==$aNav['data']['id']) { echo ' menu-custom';}?>"><a  hideFocus="true" href="<?php echo $pageUrl; ?>" ><?php echo $aNav['data']['name']; ?></a>
					<?php }?>
					<?php
					if (isset($aNav['son']) && is_array($aNav['son'])) {
						?>
						<ul class="sub-pubmenu hidden">
						<?php
						foreach ($aNav['son'] as $row) {
							if (!isset($row['data']) || $row['data']['in_use'] != '1') {continue;}
							$pid = $row['data']['page_id'];
							$uri = array();
								//if (isset($pageList[$pid]) && $pageList[$pid]['native'] == '0') {
									$uri = array(
											'page_id' => $pid,
											'navId' => $row['data']['id']
											);
								//}
								if ($pid == '-1') {
									$sonUrl = $row['data']['url'];
								} else {
									$sonUrl 	= isset($pageList[$pid]['url']) ? URL($pageList[$pid]['url'], $uri) : '#';
								}
								//$target  	= $row['data']['is_blank'] ? ' target="_blank" ' : '';
								if($aNav['data']['page_id']==-1&&!strpos($aNav['data']['url'],W_BASE_HTTP . W_BASE_URL_PATH)){
										$target='_blank';	
									}
								else{
									$target='';
								}
								$selected = $row['data']['id'] == V('g:navId')?' cur-custom':'';
								echo "<li><a href='$sonUrl' $target class='cur-common $selected'>{$row['data']['name']}</a></li>";
						}
						?>
						</ul>
						<span class="sub-arrow"></span>
						<?php
					}

						$is_first = false;
					?>
						</li><!-- 公用闭合LI -->
			<?php } ?>
<!--            	<li><a hideFocus="true" class="menu-pub" href="<?php echo URL('pub');?>">微博广场</a></li>-->
<!--                <li><a hideFocus="true" class="menu-user" href="<?php echo URL('search.recommend');?>">名人堂</a></li>-->
<!--                <li><a hideFocus="true" class="menu-home" href="<?php echo URL('index');?>">我的首页</a></li>-->
<!--                <li><a hideFocus="true" class="menu-weibo" href="<?php echo URL('index.profile');?>">我的微博</a></li>-->
            </ul>
			<div class="menu-bg">
                <span class="r-bg"></span>
                <span class="l-bg"></span>
            </div>
        </div>
