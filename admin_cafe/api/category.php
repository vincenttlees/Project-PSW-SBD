<?php
// ============================================================
// DOUBLE2CAFE — Category API
// GET    api/category.php        — list all categories
// POST   api/category.php        — create category
// PUT    api/category.php?id=X   — update category
// DELETE api/category.php?id=X   — delete category
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
                SELECT c.CategoryID,
                       c.CategoryName,
                       a.Username  AS AddedBy,
                       ci.ImagePath
                FROM   CATEGORY c
                LEFT JOIN ADMIN          a  ON a.AdminID = c.CatAddedBy
                LEFT JOIN CATEGORY_IMAGE ci ON ci.Cat_ID = c.CategoryID
                ORDER BY c.CategoryID ASC
            ")->fetchAll();
            respond($rows);
        } catch (PDOException $e) {
            respond(['error' => 'Failed to load categories: ' . $e->getMessage()], 500);
        }
        break;

    // ── CREATE ───────────────────────────────────────────────
    case 'POST':
        $name = trim($_POST['CategoryName'] ?? '');
        if (!$name) respond(['error' => 'CategoryName required'], 400);

        try {
            $adminID = getAdminID();
            $catID   = nextCharId($pdo, 'CATEGORY', 'CategoryID', 'C');

            $pdo->prepare("INSERT INTO CATEGORY (CategoryID, CategoryName, CatAddedBy) VALUES (?, ?, ?)")
                ->execute([$catID, $name, $adminID]);

            $imgPath = handleImageUpload('image', 'category');

            $pdo->prepare("INSERT INTO CATEGORY_IMAGE (Cat_ID, ImagePath) VALUES (?, ?)")
                ->execute([$catID, $imgPath]);

            respond(['success' => true, 'CategoryID' => $catID, 'ImagePath' => $imgPath], 201);
        } catch (PDOException $e) {
            respond(['error' => 'Failed to create category: ' . $e->getMessage()], 500);
        }
        break;

    // ── UPDATE ───────────────────────────────────────────────
    case 'PUT':
        if (!$id) respond(['error' => 'id required'], 400);

        $name = trim($_POST['CategoryName'] ?? '');
        if (!$name) respond(['error' => 'CategoryName required'], 400);

        try {
            $pdo->prepare("UPDATE CATEGORY SET CategoryName = ? WHERE CategoryID = ?")
                ->execute([$name, $id]);

            $imgPath = handleImageUpload('image', 'category');

            if ($imgPath !== null) {
                // Delete old image file from disk
                $old = $pdo->prepare("SELECT ImagePath FROM CATEGORY_IMAGE WHERE Cat_ID = ?");
                $old->execute([$id]);
                $oldRow = $old->fetch();
                if ($oldRow && $oldRow['ImagePath']) {
                    deleteImage($oldRow['ImagePath']);
                }

                // Upsert image record
                $pdo->prepare("
                    MERGE CATEGORY_IMAGE AS target
                    USING (SELECT ? AS Cat_ID, ? AS ImagePath) AS src
                        ON target.Cat_ID = src.Cat_ID
                    WHEN MATCHED THEN
                        UPDATE SET target.ImagePath = src.ImagePath
                    WHEN NOT MATCHED THEN
                        INSERT (Cat_ID, ImagePath) VALUES (src.Cat_ID, src.ImagePath);
                ")->execute([$id, $imgPath]);
            }

            respond(['success' => true, 'ImagePath' => $imgPath]);
        } catch (PDOException $e) {
            respond(['error' => 'Failed to update category: ' . $e->getMessage()], 500);
        }
        break;

    // ── DELETE ───────────────────────────────────────────────
    case 'DELETE':
    if (!$id) respond(['error' => 'id required'], 400);

    try {
        // Get image path first
        $img = $pdo->prepare("SELECT ImagePath FROM CATEGORY_IMAGE WHERE Cat_ID = ?");
        $img->execute([$id]);
        $imgRow = $img->fetch();

        // Use a transaction so both deletes succeed or neither does
        $pdo->beginTransaction();
        $pdo->prepare("DELETE FROM CATEGORY_IMAGE WHERE Cat_ID = ?")->execute([$id]);
        $pdo->prepare("DELETE FROM CATEGORY WHERE CategoryID = ?")->execute([$id]);
        $pdo->commit();

        // Only delete the file after DB is confirmed clean
        if ($imgRow && $imgRow['ImagePath']) {
            deleteImage($imgRow['ImagePath']);
        }

        respond(['success' => true]);
    } catch (PDOException $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        if (strpos($e->getMessage(), '547') !== false || strpos($e->getMessage(), 'REFERENCE') !== false || strpos($e->getMessage(), 'FK') !== false) {
            respond(['error' => 'Cannot delete this category because it still has menu items. Please reassign or delete those menus first.'], 409);
        }
        respond(['error' => 'Failed to delete category: ' . $e->getMessage()], 500);
    }
    break;

    default:
        respond(['error' => 'Method not allowed'], 405);
}