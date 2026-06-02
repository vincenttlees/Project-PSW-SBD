<?php

include 'koneksi.php';

header('Content-Type: application/json');

// ambil categoryID dari URL
$categoryID = $_GET['categoryID'];

// query category name
$sqlCategory = "
SELECT CategoryName
FROM CATEGORY
WHERE LOWER(CategoryID) = LOWER(?)
";

$paramsCategory = array($categoryID);

$stmtCategory = sqlsrv_query($conn, $sqlCategory, $paramsCategory);

$categoryData = sqlsrv_fetch_array($stmtCategory, SQLSRV_FETCH_ASSOC);

$categoryName = $categoryData['CategoryName'];


// query menu berdasarkan kategori
$sqlMenu = "
SELECT 
    MenuName,
    ShortDesc,
    Price
FROM MENU
WHERE LOWER(CatID) = LOWER(?)
";

$paramsMenu = array($categoryID);

$stmtMenu = sqlsrv_query($conn, $sqlMenu, $paramsMenu);

$menuList = array();

while ($row = sqlsrv_fetch_array($stmtMenu, SQLSRV_FETCH_ASSOC)) {

    $menuList[] = array(
        "MenuName" => $row['MenuName'],
        "ShortDesc" => $row['ShortDesc'],
        "Price" => $row['Price']
    );

}

// hasil JSON
$result = array(
    "category" => $categoryName,
    "menu" => $menuList
);

echo json_encode($result);

?>