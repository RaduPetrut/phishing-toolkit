<?php
//$uid = 101;
$uid = $_GET['uid'];
//$cid = 303;
$cid = $_GET['cid'];
//$vid = 1;
$vid = $_GET['vid'];
$username = $_POST['UsernameForm'];
$password = $_POST['PasswordForm'];
$url = 'http://localhost:3000/create/report';
$data = array('uid' => $uid, 'cid' => $cid, 'vid' => $vid, 'username' => $username, 'password' => $password);

// use key 'http' even if you send the request to https://...
$options = array(
    'http' => array(
        'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
        'method'  => 'POST',
        'content' => http_build_query($data)
    )
);
$context  = stream_context_create($options);
$result = file_get_contents($url, false, $context);
?>

<html>
<body>

<p>Failed login!</p>

<form method="POST" action="process.php" name="LoginForm" autocomplete="off">	
	Username: <input type="text" name="UsernameForm"><br>
	Password: <input type="password" name="PasswordForm"><br>
	<input type="submit" class="submit" value="Login">
</form>

</body>
</html>

