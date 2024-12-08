<?php
session_start();

// Database connection
$db_host = 'localhost';
$db_user = 'root';
$db_pass = '';
$db_name = 'website_raicenote';

$conn = new mysqli($db_host, $db_user, $db_pass, $db_name);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if user is logged in and return user ID
$response = [
    'isLoggedIn' => isset($_SESSION['user_id']),
    'user_id' => isset($_SESSION['user_id']) ? $_SESSION['user_id'] : null,
    'success' => true
];

header('Content-Type: application/json');
echo json_encode($response);
exit;
?>
