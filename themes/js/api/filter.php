<?php
$category = isset($_POST['categories-list']) ? htmlspecialchars($_POST['categories-list']) : '';
$minPrice = isset($_POST['minPrice']) ? htmlspecialchars($_POST['minPrice']) : '';
$maxPrice = isset($_POST['maxPrice']) ? htmlspecialchars($_POST['maxPrice']) : '';
$alcoholPercentage = isset($_POST['alcoholPercentage']) ? htmlspecialchars($_POST['alcoholPercentage']) : '';

$db_host = 'localhost';
$db_user = 'root';
$db_pass = '';
$db_name = 'website_raicenote';

$conn = new mysqli($db_host, $db_user, $db_pass, $db_name);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$category_clause = "";
$price_clause = "";
$aP_clause = "";
$extra = " WHERE";

$opening_part = "SELECT product_id, name, category, price, image_url FROM products";

if ($category) {
    if ($category == 'All Categories') {
        $category_clause = "";
    } else if ($category == 'Collections') {
        $category_clause = "$extra is_bundle = 1";
        $extra = " AND";
    } else if ($category == 'Others') {
        $category_clause = "$extra category NOT IN ('Korean rice wine', 'Japanese rice wine', 'Chinese rice wine') AND is_bundle != 1";
        $extra = " AND";
    }else {
        $category_clause = "$extra category = '$category'";
        $extra = " AND";
    }
}
if ($minPrice && $maxPrice) {
    $price_clause = "$extra price BETWEEN '$minPrice' AND '$maxPrice'";
    $extra = " AND";
}
if ($alcoholPercentage) {
    $aP_clause = "$extra alcohol_percentage = '$alcoholPercentage'";
}

$sql_statement = "$opening_part$category_clause$price_clause$aP_clause";
// echo $category;
// echo $sql_statement;
$result = $conn->query($sql_statement);
$num_result = mysqli_num_rows($result);



$placeHolderImage = '../uploads/placeholder.jpg';
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        echo '<div class="col-6 col-md-4 col-lg-4 mb-4">
<div class="card product-card">
    <img 
        src="' . htmlspecialchars($row['image_url'], ENT_QUOTES, 'UTF-8') . '"
        alt="' . htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8') . '"
        class="card-img-top product-image"
        onerror="this.onerror=null; this.src=\'' . htmlspecialchars($placeHolderImage, ENT_QUOTES, 'UTF-8') . '\'; this.className+=\' placeholder\'"
    >
    <div class="card-body">
        <h5 class="card-title">' . htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8') . '</h5>
        <p class="card-text">$' . number_format((float)$row['price'], 2, '.', '') . '</p>
        <button class="btn btn-primary add-to-cart" data-product-id="' . htmlspecialchars($row['product_id'], ENT_QUOTES, 'UTF-8') . '">Add to Cart</button>
    </div>
</div>
</div>';
    }
} else {
    echo "No products found.";
}

$conn->close();
