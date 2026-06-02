<?php

$serverName = "localhost\\SQLEXPRESS";
$connectionOptions = array(
    "Database" => "DOUBLE2CAFE",
    "Encrypt" => false,
    "TrustServerCertificate" => true
);

$conn = sqlsrv_connect($serverName, $connectionOptions);

if (!$conn) {
    die(print_r(sqlsrv_errors(), true));
}

?>