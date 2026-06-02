<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Login — D2 Caferaria</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="login.css">
</head>
<body>

<div class="login-container">
    <div class="left">
        <img src="foto/Logo D2 Cafe.png" alt="D2 Caferaria" onerror="this.style.display='none'; document.querySelector('.logo-fallback').style.display='flex'">
        <div class="logo-fallback">
            <span class="logo-icon">☕</span>
            <h1>D2</h1>
            <p>Caferaria</p>
        </div>
    </div>
    <div class="right">
        <div class="form-wrap">
            <h2>Welcome Back</h2>
            <p class="subtitle">Sign in to your dashboard</p>

            <div class="input-group">
                <label>Username</label>
                <input type="text" id="username" placeholder="Enter username" autocomplete="username">
            </div>
            <div class="input-group">
                <label>Password</label>
                <input type="password" id="password" placeholder="Enter password" autocomplete="current-password">
            </div>

            <button id="loginBtn" onclick="doLogin()">
                <span id="btnText">Sign In</span>
                <span id="btnLoader" class="hidden">⏳</span>
            </button>

            <p id="error"></p>
        </div>
    </div>
</div>

<script src="login.js"></script>
</body>
</html>
