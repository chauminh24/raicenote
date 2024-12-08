<?php
header('Content-Type: application/json');

$db_host = 'localhost';
$db_user = 'root';
$db_pass = '';
$db_name = 'website_raicenote';

$conn = new mysqli($db_host, $db_user, $db_pass, $db_name);

if ($conn->connect_error) {
    die(json_encode(['error' => "Connection failed: " . $conn->connect_error]));
}

// Check if product ID is provided
if (!isset($_GET['id'])) {
    die(json_encode(['error' => 'No product ID provided']));
}

$product_id = intval($_GET['id']);

// Prepare and execute query
$stmt = $conn->prepare("SELECT * FROM products WHERE product_id = ?");
$stmt->bind_param("i", $product_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    die(json_encode(['error' => 'Product not found']));
}

$product = $result->fetch_assoc();

// Clean up
$stmt->close();
$conn->close();

// Return product details as JSON
echo json_encode($product);
