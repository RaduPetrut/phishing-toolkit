<html>
<body>

<form method="POST" action="process.php?uid=<?php echo $_GET['uid'] ?>&cid=<?php echo $_GET['cid'] ?>&vid=<?php echo $_GET['vid'] ?>" name="LoginForm" autocomplete="off">	
	Username: <input type="text" name="UsernameForm"><br>
	Password: <input type="password" name="PasswordForm"><br>
	<input type="submit" class="submit" value="Login">
</form>

</body>
</html>

