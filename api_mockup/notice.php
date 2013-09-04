<?php
date_default_timezone_set("Asia/Hong_Kong");

$command = $_REQUEST['mod'];
call_user_func("api_{$command}");

function api_list() {

	$ret = array();

	if (is_numeric($_REQUEST['messageid'])) {
		$next_id = $_REQUEST['messageid']+1;
		$need_reply = "1";
		$f = "replies/replies_{$next_id}";
		if (file_exists($f)) {
			$need_reply = "2";
		}
		$ret[] = array(
			"messageid" => "{$next_id}",
			"content" => "通知".$next_id."拉姆塞梅开二度 阿森纳总分5-0连16年进正赛",
			"teacherName" => "张主任",
			"teacher_id" => "1",
			"created_at" => date("Y-m-d H:i"),
			"is_reply" => $need_reply,
			"type" => "4"
		);
	}else {
		
		$ret[] = array(
			"messageid" => "2",
			"content" => "通知2",
			"teacherName" => "教师1",
			"teacher_id" => "1",
			"created_at" => "2013-08-24 10:00",
			"is_reply" => "0",
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

	$message_id = $_REQUEST['messageid'];

	$f = "replies/replies_{$message_id}";
	if (file_exists($f)) {
		$replies = file_get_contents($f);
		if ($replies!="") {
			$ret['reply_array'] = unserialize($replies);
		}
	}

	echo json_encode($ret);
	exit;
}

function api_reply() {
	$ret = array("success"=>true);

	$message_id = $_REQUEST['notice_id'];
	
	$rp = array();

	$f = "replies/replies_{$message_id}";
	if(file_exists($f)) {
		$replies = file_get_contents($f);
		if ($replies!="") {
			$rp = unserialize($replies);
		}
	}


	$rp[] = array("hfid"=>"0", "content"=>$_REQUEST['content'], "created_at"=>date("Y-m-d H:i"));

	file_put_contents($f, serialize($rp));

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

/*
{
class:[{"class_id" : "xxxx","class_name" : "xxxx"},{"class_id" : "xxxx","class_name" : "xxxx"}]
teacher:[{"teacher_id" : "xxxx","teacher_name" : "xxxx","phone" : "xxx","class_name":"xxx"},{"teacher_id" : "xxxx","teacher_name" : "xxxx","phone" : "xxx",class_name:"xxx"}]
student:[{"student_id" : "xxxx","student_name" : "xxxx","phone" : "xxx","class_name":"xxx"},{"student_id" : "xxxx","student_name" : "xxxx","phone" : "xxx",""class_name":"xxx"}]
}
*/
function api_get_contacts() {
	$ret = array();
	$ret['class'][] = array(
		"class_id" => "3",
		"class_name" => "班级1"
	);
	$ret['class'][] = array(
		"class_id" => "4",
		"class_name" => "班级2"
	);

	$ret['teacher'][] = array(
		"teacher_id" => "5",
		"teacher_name" => "老师5",
		"phone" => "130000000",
		"class_name" => "班级1"
	);

	$ret['teacher'][] = array(
		"teacher_id" => "6",
		"teacher_name" => "老师6",
		"phone" => "130000001",
		"class_name" => "班级2"
	);

	$ret['student'][] = array(
		"student_id" => "3",
		"student_name" => "学生3",
		"phone" => "130000003",
		"class_name" => "班级2"
	);

	$ret['student'][] = array(
		"student_id" => "4",
		"student_name" => "学生4",
		"phone" => "130000004",
		"class_name" => "班级2"
	);

	echo json_encode($ret);
}