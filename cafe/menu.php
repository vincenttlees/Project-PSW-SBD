<?php
include 'koneksi.php';

$sql = "
SELECT 
    c.CategoryID,
    c.CategoryName,
    ci.ImagePath
FROM CATEGORY c
LEFT JOIN CATEGORYIMAGE ci
ON c.CategoryID = ci.Cat_ID
";

$query = sqlsrv_query($conn, $sql);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<header class="navbar">
    <div class="logo"><a href="index.php">D2 Cafetaria</a></div>
    <nav>
        <ul>
            <li><a href="index.php">Home</a></li>
        </ul>
    </nav>
</header>

<section class="menu-page">
    <h1>MENU</h1>

    <div class="menu-grid">
        <?php

$sql = "
SELECT 
    c.CategoryID,
    c.CategoryName,
    ci.ImagePath
FROM CATEGORY c
LEFT JOIN CATEGORY_IMAGE ci 
ON c.CategoryID = ci.Cat_ID
";
$stmt = sqlsrv_query($conn, $sql);

if ($stmt === false) {
    die(print_r(sqlsrv_errors(), true));
}

while ($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)) {
?>

    <div class="menu-card" data-category="<?php echo strtolower($row['CategoryID']); ?>">

    <img src="<?php echo $row['ImagePath']; ?>" alt="gambar Menu">

    <h3><?php echo $row['CategoryName']; ?></h3>

</div>
<?php
}
?>

</div>

    <button class="back-btn" onclick="goHome()">← Kembali ke Beranda</button>
</section>

<!-- =========================
     POPUP MENU
========================= -->

<div id="menuModal">

    <div id="menuPopup">

        <div id="popupHeader">

            <h2 id="MenuName"></h2>

            <button id="closePopup">
                ×
            </button>

        </div>

        <div id="menuList"></div>

    </div>

</div>
<script src="script.js"></script>
</body>
</html>