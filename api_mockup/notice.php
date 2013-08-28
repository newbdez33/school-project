<?php
date_default_timezone_set("Asia/Hong_Kong");

$command = $_REQUEST['mod'];
call_user_func("api_{$command}");

function api_list() {

	$ret = array();

	if (is_numeric($_REQUEST['messageid'])) {
		$next_id = $_REQUEST['messageid']+1;
		$ret[] = array(
			"messageid" => "{$next_id}",
			"content" => "通知".$next_id."拉姆塞梅开二度 阿森纳总分5-0连16年进正赛",
			"teacherName" => "张主任",
			"teacher_id" => "1",
			"created_at" => date("Y-m-d H:i"),
			"is_reply" => "1",
			"type" => "4"
		);
	}else {
		
		$ret[] = array(
			"messageid" => "2",
			"content" => "通知2",
			"teacherName" => "教师1",
			"teacher_id" => "1",
			"created_at" => "2013-08-24 10:00",
			"is_reply" => "2",
			"type" => "4"
		);
		$ret[] = array(
			"messageid" => "1",
			"content" => "通知1",
			"teacherName" => "教师1",
			"teacher_id" => "1",
			"created_at" => "2013-08-24 22:10",
			"is_reply" => "1",
			"type" => "4"
		);
	}

	echo json_encode($ret);
	exit;
}

//notice.php?mod=view&uid=xxx&messageid=xxx&type=xxx
function api_view() {
/*
{
score_array:[
{"kcName" : "xxxx","score" : "xxx"}
{"kcName" : "xxxx","score" : "xxx"}
{"kcName" : "xxxx","score" : "xxx"}
]
reply_array:[
{hfid:"", content:"内容一", created_at:"日期一"},
{hfid:"", content:"内容二", created_at:"日期二"}
]
}
*/
	$ret = array();
	$ret['score_array'] = array(
		array("kcName"=>"语文", "score"=>"90分"),
		array("kcName"=>"数学", "score"=>"100分"),
		array("kcName"=>"英文", "score"=>"0分"),
		array("kcName"=>"总文", "score"=>"190分")
	);
	$ret['reply_array'] = array(
		array("hfid"=>"1", "content"=>"内容1", "created_at"=>"2013-09-08 07:06:05"),
		array("hfid"=>"2", "content"=>"内容2", "created_at"=>"2013-10-08 07:06:05")
	);

	echo json_encode($ret);
	exit;
}

function api_reply() {
	$ret = array("success"=>true);
	echo json_encode($ret);
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