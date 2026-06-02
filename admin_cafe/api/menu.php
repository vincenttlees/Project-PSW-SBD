<?php
// ============================================================
// DOUBLE2CAFE — Menu API
// GET    api/menu.php        — list all menu items
// POST   api/menu.php        — create menu item
// PUT    api/menu.php?id=X   — update menu item
// DELETE api/menu.php?id=X   — delete menu item
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

    // ── LIST ─────────────────────────────────────────────────
    case 'GET':
        try {
            $rows = $pdo->query("
                SELECT m.MenuID,
                       m.MenuName,
                       m.Price,
                       m.ShortDesc,
                       m.CreatedAt,
                       c.CategoryID,
                       c.CategoryName,
                       a.Username AS AddedBy
                FROM   MENU m
                LEFT JOIN CATEGORY c ON c.CategoryID = m.CatID
                LEFT JOIN ADMIN    a ON a.AdminID    = m.MenAddedBy
                ORDER BY m.MenuID ASC
            ")->fetchAll();
            respond($rows);
        } catch (PDOException $e) {
            respond(['error' => 'Failed to load menu: ' . $e->getMessage()], 500);
        }
        break;

    // ── CREATE ───────────────────────────────────────────────
    case 'POST':
        $menuName  = trim($_POST['MenuName']  ?? '');
        $price     = trim($_POST['Price']     ?? '');
        $catID     = trim($_POST['CatID']     ?? '');
        $shortDesc = trim($_POST['ShortDesc'] ?? '');
        $adminID   = getAdminID();

        if (!$menuName || $price === '') respond(['error' => 'MenuName and Price required'], 400);

        try {
            $menuID = nextCharId($pdo, 'MENU', 'MenuID', 'M');

            $pdo->prepare("
                INSERT INTO MENU (MenuID, MenuName, Price, CatID, MenAddedBy, ShortDesc, CreatedAt)
                VALUES (?, ?, ?, ?, ?, ?, GETDATE())
            ")->execute([
                $menuID,
                $menuName,
                (int)$price,
                $catID ?: 'UNKN',
                $adminID,
                $shortDesc ?: null,
            ]);

            respond(['success' => true, 'MenuID' => $menuID], 201);
        } catch (PDOException $e) {
            respond(['error' => 'Failed to create menu item: ' . $e->getMessage()], 500);
        }
        break;

    // ── UPDATE ───────────────────────────────────────────────
    case 'PUT':
        if (!$id) respond(['error' => 'id required'], 400);

        $menuName  = trim($_POST['MenuName']  ?? '');
        $price     = trim($_POST['Price']     ?? '');
        $catID     = trim($_POST['CatID']     ?? '');
        $shortDesc = trim($_POST['ShortDesc'] ?? '');

        if (!$menuName || $price === '') respond(['error' => 'MenuName and Price required'], 400);

        try {
            $pdo->prepare("
                UPDATE MENU
                SET MenuName=?, Price=?, CatID=?, ShortDesc=?
                WHERE MenuID=?
            ")->execute([$menuName, (int)$price, $catID ?: 'UNKN', $shortDesc ?: null, $id]);

            respond(['success' => true]);
        } catch (PDOException $e) {
            respond(['error' => 'Failed to update menu item: ' . $e->getMessage()], 500);
        }
        break;

    // ── DELETE ───────────────────────────────────────────────
    case 'DELETE':
        if (!$id) respond(['error' => 'id required'], 400);

        try {
            $pdo->prepare("DELETE FROM MENU WHERE MenuID = ?")->execute([$id]);
            respond(['success' => true]);
        } catch (PDOException $e) {
            respond(['error' => 'Failed to delete menu item: ' . $e->getMessage()], 500);
        }
        break;

    default:
        respond(['error' => 'Method not allowed'], 405);
}