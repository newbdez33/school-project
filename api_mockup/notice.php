<?php
$command = $_REQUEST['mod'];
call_user_func("api_{$command}");

function api_list() {
	$ret = array();
	$ret['success'] = true;
	$ret['result'] = array();
	$ret['result'][] = array(
		"messageid" => "1",
		"content" => "通知1",
		"teacherName" => "教师1",
		"teacher_id" => "1",
		"created_at" => "2013-08-24",
		"is_reply" => true,
		"type" => "4"
	);
	$ret['result'][] = array(
		"messageid" => "2",
		"content" => "通知2",
		"teacherName" => "教师1",
		"teacher_id" => "1",
		"created_at" => "2013-08-24 10:00",
		"is_reply" => false,
		"type" => "4"
	);

	echo json_encode($ret);
	exit;
}

function api_view() {
	exit;
}

function api_reply() {
	exit;
}

function api_add() {
	exit;
}

function api_get_grades() {
	exit;
}

function api_get_classes() {
	exit;
}

function api_get_student() {
	exit;
}