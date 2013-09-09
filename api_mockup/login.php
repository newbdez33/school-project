<?php
error_reporting(0);
$ret = array();

if ($_REQUEST['username']=="student1" && $_REQUEST['password']=="123456") {
	$ret['success'] = true;
	$ret['userid'] = "1";
	$ret["role_id"] = "4";
	$ret["school_id"] = "1";

	$ret['name'] = "学生1";
	$ret['class_name'] = "三年二班";
	$ret['head_teacher'] = "老师1";

	echo json_encode($ret);
	exit;
}

if ($_REQUEST['username']=="teacher1" && $_REQUEST['password']=="654321") {
	$ret['success'] = true;
	$ret['userid'] = "1";
	$ret["role_id"] = "3";
	$ret["school_id"] = "1";

	$ret['name'] = "老师1";
	$ret['class_name'] = "三年二班";
	$ret['head_teacher'] = "";

	echo json_encode($ret);
	exit;
}


$ret['success'] = false;
$ret['error_msg'] = "用户名或密码错误";


echo json_encode($ret);

