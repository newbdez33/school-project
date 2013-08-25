<?php
$ret = array();
$ret['success'] = true;
$ret['userid'] = 1;
$ret['error_msg'] = "测试错误";
$ret["role_id"] = 3;
$ret["school_id"] = 1;

echo json_encode($ret);

