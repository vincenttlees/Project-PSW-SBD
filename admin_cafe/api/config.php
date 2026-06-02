<?php
// ============================================================
// DOUBLE2CAFE — Database Configuration (SQL Server / Laragon)
// ============================================================

define('DB_HOST', 'localhost\SQLEXPRESS');
define('DB_USER', '');   // Windows Authentication — leave blank
define('DB_PASS', '');
define('DB_NAME', 'DOUBLE2CAFE');

// Images live in C:/laragon/www/cafe/Images/ (separate from this project at double2cafe/)
// Physical save path:
define('UPLOAD_PATH', 'C:/laragon/www/cafe/Images/');
// Full URL the browser uses to load those images:
define('UPLOAD_URL',  'Images/');

// ── CORS & JSON headers ──────────────────────────────────────
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// ── DB CONNECTION ────────────────────────────────────────────
try {
    $dsn = "sqlsrv:Server=" . DB_HOST . ";Database=" . DB_NAME . ";TrustServerCertificate=1";
    $pdo = new PDO($dsn, null, null, [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection failed: ' . $e->getMessage()]);
    exit();
}

// ── SESSION ──────────────────────────────────────────────────
session_start();

function getAdminID() {
    return $_SESSION['admin_id'] ?? null;
}

function requireAuth() {
    if (!isset($_SESSION['admin_id'])) {
        http_response_code(401);
        echo json_encode(['error' => 'Unauthorized']);
        exit();
    }
}

// ── HELPERS ──────────────────────────────────────────────────
function respond($data, $code = 200) {
    http_response_code($code);
    echo json_encode($data);
    exit();
}

/**
 * Generate the next CHAR(4) ID for a given table and prefix.
 */
function nextCharId($pdo, $table, $column, $prefix) {
    $stmt = $pdo->prepare(
        "SELECT MAX(CAST(SUBSTRING($column, 2, 4) AS INT)) AS MaxNum FROM $table WHERE $column LIKE ?"
    );
    $stmt->execute([$prefix . '%']);
    $row    = $stmt->fetch();
    $maxNum = (int)($row['MaxNum'] ?? 0);
    return $prefix . str_pad($maxNum + 1, 3, '0', STR_PAD_LEFT);
}

/**
 * Handle image upload. Returns the relative URL path or null if no file.
 */
function handleImageUpload($fileKey, $subfolder) {
    if (!isset($_FILES[$fileKey]) || $_FILES[$fileKey]['error'] !== UPLOAD_ERR_OK) {
        return null;
    }

    $file     = $_FILES[$fileKey];
    $allowed  = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];
    $mimeType = mime_content_type($file['tmp_name']);

    if (!in_array($mimeType, $allowed)) {
        respond(['error' => 'Only JPG, PNG, WEBP, GIF images allowed'], 400);
    }

    $ext      = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    $filename = uniqid($subfolder . '_', true) . '.' . $ext;
    $dir      = UPLOAD_PATH;

    if (!is_dir($dir)) {
        mkdir($dir, 0755, true);
    }

    $dest = $dir . $filename;
    if (!move_uploaded_file($file['tmp_name'], $dest)) {
        respond(['error' => 'Failed to save image. Check folder permissions for: ' . $dir], 500);
    }

    return UPLOAD_URL . $filename;
}

/**
 * Delete an image file from disk given its URL path (e.g. "Images/filename.jpg").
 */
function deleteImage($urlPath) {
    if (!$urlPath) return;
    $filename = basename($urlPath);
    $abs      = UPLOAD_PATH . $filename;
    if (file_exists($abs)) {
        @unlink($abs);
    }
}