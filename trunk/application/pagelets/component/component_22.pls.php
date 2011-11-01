<?php

require_once dirname(__FILE__). '/component_abstract.pls.php';
/**
 * 本地关注排行榜
 * @author yaoying
 * @version $Id: component_17.pls.php 10863 2011-02-28 07:11:07Z yaoying $
 *
 */
class component_22_pls extends component_abstract_pls
{
	
	function run($mod)
	{
		parent::run($mod);
		echo TPL::module('component/component_'.$mod['component_id'], array('mod'=>$mod), false);
		return;
	}
}
