<?php
// ============================================================
// DOUBLE2CAFE — Auth API
// POST api/auth.php?action=login   { username, password }
// GET  api/auth.php?action=logout
// GET  api/auth.php?action=check
// ============================================================
require_once 'config.php';

$action = $_GET['action'] ?? '';

switch ($action) {

    case 'login':
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') respond(['error' => 'POST required'], 405);

        $body     = json_decode(file_get_contents('php://input'), true);
        $username = trim($body['username'] ?? '');
        $password = trim($body['password'] ?? '');

        if (!$username || !$password) respond(['error' => 'Username and password required'], 400);

        $stmt = $pdo->prepare("SELECT AdminID, Username, Password FROM ADMIN WHERE Username = ?");
        $stmt->execute([$username]);
        $admin = $stmt->fetch();

        if (!$admin) respond(['error' => 'Invalid credentials'], 401);

        // Support both plain text (legacy seed data) and bcrypt
        $valid = ($password === $admin['Password']) || password_verify($password, $admin['Password']);

        if (!$valid) respond(['error' => 'Invalid credentials'], 401);

        $_SESSION['admin_id']   = $admin['AdminID'];
        $_SESSION['admin_name'] = $admin['Username'];

        respond(['success' => true, 'username' => $admin['Username'], 'adminId' => $admin['AdminID']]);
        break;

    case 'logout':
        session_destroy();
        respond(['success' => true]);
        break;

    case 'check':
        if (isset($_SESSION['admin_id'])) {
            respond([
                'loggedIn' => true,
                'username' => $_SESSION['admin_name'],
                'adminId'  => $_SESSION['admin_id']
            ]);
        } else {
            respond(['loggedIn' => false]);
        }
        break;

    default:
        respond(['error' => 'Unknown action'], 400);
}