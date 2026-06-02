<?php
// ============================================================
// DOUBLE2CAFE — Admin Users API
// GET    api/admin_users.php        — list admins
// POST   api/admin_users.php        — create admin
// PUT    api/admin_users.php?id=X   — update admin
// DELETE api/admin_users.php?id=X   — delete admin
// ============================================================
require_once 'config.php';
requireAuth();

// Support method tunneling: POST ?_method=PUT or ?_method=DELETE
$method = $_SERVER['REQUEST_METHOD'];
if ($method === 'POST' && isset($_GET['_method'])) {
    $method = strtoupper($_GET['_method']);
}
$id = isset($_GET['id']) ? trim($_GET['id']) : null;

switch ($method) {

    case 'GET':
        try {
            $rows = $pdo->query("
                SELECT AdminID, Username, CreatedAt
                FROM   ADMIN
                ORDER BY AdminID ASC
            ")->fetchAll();
            respond($rows);
        } catch (PDOException $e) {
            respond(['error' => 'Failed to load admins: ' . $e->getMessage()], 500);
        }
        break;

    case 'POST':
        $body     = json_decode(file_get_contents('php://input'), true);
        $username = trim($body['username'] ?? '');
        $password = trim($body['password'] ?? '');
        if (!$username || !$password) respond(['error' => 'Username and password required'], 400);

        try {
            $hashed  = password_hash($password, PASSWORD_BCRYPT);
            $adminID = nextCharId($pdo, 'ADMIN', 'AdminID', 'A');

            $pdo->prepare("INSERT INTO ADMIN (AdminID, Username, Password, CreatedAt) VALUES (?, ?, ?, GETDATE())")
                ->execute([$adminID, $username, $hashed]);
            respond(['success' => true, 'AdminID' => $adminID], 201);
        } catch (PDOException $e) {
            respond(['error' => 'Username already exists or DB error: ' . $e->getMessage()], 409);
        }
        break;

    case 'PUT':
        if (!$id) respond(['error' => 'id required'], 400);
        $body     = json_decode(file_get_contents('php://input'), true);
        $username = trim($body['username'] ?? '');
        $password = trim($body['password'] ?? '');

        if (!$username) respond(['error' => 'Username required'], 400);

        try {
            if ($password) {
                $hashed = password_hash($password, PASSWORD_BCRYPT);
                $pdo->prepare("UPDATE ADMIN SET Username=?, Password=? WHERE AdminID=?")
                    ->execute([$username, $hashed, $id]);
            } else {
                $pdo->prepare("UPDATE ADMIN SET Username=? WHERE AdminID=?")
                    ->execute([$username, $id]);
            }
            respond(['success' => true]);
        } catch (PDOException $e) {
            respond(['error' => 'Failed to update admin: ' . $e->getMessage()], 500);
        }
        break;

    case 'DELETE':
        if (!$id) respond(['error' => 'id required'], 400);
        if ($id === getAdminID()) respond(['error' => 'Cannot delete yourself'], 400);

        try {
            $pdo->prepare("DELETE FROM ADMIN WHERE AdminID=?")->execute([$id]);
            respond(['success' => true]);
        } catch (PDOException $e) {
            respond(['error' => 'Failed to delete admin: ' . $e->getMessage()], 500);
        }
        break;

    default:
        respond(['error' => 'Method not allowed'], 405);
}