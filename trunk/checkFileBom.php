<?php

set_time_limit(5*3600);

$basedir="."; //修改此行为需要检测的目录，点表示当前目录
$auto = 1; //是否自动移除发现的BOM信息。1为是，0为否。


//如果是命令行运行，可直接传参数而不需要修改上面的参数：
//php -f checkFileBom.php "要检测的dir" 1
//if(isset($argv[1])){
//	$basedir = $argv[1];
//}
//if(isset($argv[2])){
//	$auto = 1;
//}else{
//	$auto = 0;
//}

if(!is_dir($basedir)){
	trigger_error($basedir. ' is not a directory!', E_USER_ERROR);
}


//以下不用改动

function runCheckBom($basedir)
{
	if ($dh = opendir($basedir)) 
	{
		while (($file = readdir($dh)) !== false) 
		{
			if ($file!='.' && $file!='..') 
			{
				if ( is_dir($basedir."/".$file) )
				{
					runCheckBom($basedir."/".$file);
				}
				else if ( checkBOM("$basedir/$file") )
				{
					$tmpAry = explode('.', $file);
					$ext = array_pop( $tmpAry );
					if (in_array(strtolower($ext), array('php', 'html', 'htm'))){
						echo "filename: $basedir/$file<br>\r\n";
					}
				}
			} 
		}
		closedir($dh);
	}
}

function checkBOM ($filename) 
{
	global $auto;
	$contents=file_get_contents($filename);
	$charset[1]=substr($contents, 0, 1);
	$charset[2]=substr($contents, 1, 1);
	$charset[3]=substr($contents, 2, 1);
	
	$tmpAry = explode('.', $filename);
	$ext 	= array_pop( $tmpAry );
	if (in_array(strtolower($ext), array('php', 'html', 'htm')))
	{
		if (ord($charset[1])==239 && ord($charset[2])==187 && ord($charset[3])==191) {
			if ($auto==1) {
			$rest=substr($contents, 3);
			rewrite ($filename, $rest);
//			return true;
			return ("<font color=red>--Bom 已经清除完毕。</font>");
			} else {
			return ("<font color=red>--Bom found.</font>");
			}
		}
	}
//	else return ("--没有检查到Bom.");
}
function rewrite ($filename, $data) {
$filenum=fopen($filename,"wb");
flock($filenum,LOCK_EX);
fwrite($filenum,$data);
fclose($filenum);
}


runCheckBom($basedir);