<?php
$ret = array();
$ret['success'] = true;
$ret['userid'] = 1;
$ret['error_msg'] = "测试错误";
$ret["role_id"] = 3;
$ret["school_id"] = 1;

if ($_REQUEST['username']!="a") {
	$ret['success'] = false;
	$ret['error_msg'] = "用户名或密码错误";
}

echo json_encode($ret);

