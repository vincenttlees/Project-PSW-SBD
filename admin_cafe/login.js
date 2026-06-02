// Check if already logged in
fetch('api/auth.php?action=check')
    .then(r => r.json())
    .then(data => {
        if (data.loggedIn) window.location.href = 'admin.php';
    })
    .catch(() => {}); // offline — ignore

async function doLogin() {
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value.trim();
    const error    = document.getElementById('error');
    const btn      = document.getElementById('loginBtn');
    const btnText  = document.getElementById('btnText');
    const loader   = document.getElementById('btnLoader');

    error.textContent = '';

    if (!username || !password) {
        error.textContent = 'Please enter username and password.';
        return;
    }

    btn.disabled = true;
    btnText.textContent = 'Signing in...';
    loader.classList.remove('hidden');

    try {
        const res = await fetch('api/auth.php?action=login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ username, password })
        });

        const data = await res.json();

        if (res.ok && data.success) {
            // Store minimal info for UI
            sessionStorage.setItem('adminUser', data.username);
            sessionStorage.setItem('adminId',   data.adminId);

            document.body.style.opacity = '0';
            document.body.style.transition = '0.3s';
            setTimeout(() => window.location.href = 'admin.php', 300);
        } else {
            error.textContent = data.error || 'Invalid credentials';
            btn.disabled = false;
            btnText.textContent = 'Sign In';
            loader.classList.add('hidden');
        }
    } catch (err) {
        error.textContent = 'Cannot connect to server. Is PHP running?';
        btn.disabled = false;
        btnText.textContent = 'Sign In';
        loader.classList.add('hidden');
    }
}

// Enter key support
document.addEventListener('keydown', e => {
    if (e.key === 'Enter') doLogin();
});
