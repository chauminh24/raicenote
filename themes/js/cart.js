const cartIcon = document.querySelector('.cart-container');
const cartSidebar = document.getElementById('cartSidebar');
const closeCartBtn = document.querySelector('.close-cart');
const cartItems = document.getElementById('cartItems');
const cartTotal = document.getElementById('cartTotal');
const cartCount = document.querySelector('.cart-count');

// Load cart from localStorage
document.addEventListener('DOMContentLoaded', loadCartFromLocalStorage);

// Toggle cart sidebar
cartIcon.addEventListener('click', function () {
    cartSidebar.classList.toggle('open');

    // Log when the cart sidebar is opened
    if (cartSidebar.classList.contains('open')) {
        console.log("Cart Sidebar Opened");
    } else {
        console.log("Cart Sidebar Closed");
    }
});

// Close cart button
closeCartBtn.addEventListener('click', function () {
    cartSidebar.classList.remove('open');
});

// Handle "Add to Cart" button clicks
document.querySelectorAll('.add-to-cart').forEach(button => {
    button.addEventListener('click', function () {
        const productId = this.getAttribute('data-product-id');
        const productName = this.parentElement.querySelector('.card-title').textContent;
        const productPrice = parseFloat(this.parentElement.querySelector('.card-text').textContent.replace('$', ''));
        const productImage = this.parentElement.parentElement.querySelector('.product-image').src;
        
        addToCart(productId, productName, productPrice, productImage);
    });
});

function addToCart(productId, productName, productPrice, productImage) {
    const existingCartItem = document.querySelector(`.cart-item[data-product-id="${productId}"]`);

    if (existingCartItem) {
        const quantityElem = existingCartItem.querySelector('.cart-item-quantity');
        const newQuantity = parseInt(quantityElem.textContent) + 1;
        quantityElem.textContent = newQuantity;
    } else {
        // Create a new cart item element
        const cartItem = document.createElement('div');
        cartItem.classList.add('cart-item');
        cartItem.setAttribute('data-product-id', productId);
        cartItem.innerHTML = `
            <img src="${productImage}" class="cart-item-image" alt="${productName}">
            <span class="cart-item-name">${productName}</span>
            <span class="cart-item-price">$${productPrice.toFixed(2)}</span>
            <div class="cart-item-controls">
                <button class="decrease-quantity" data-product-id="${productId}">-</button>
                <span class="cart-item-quantity">1</span>
                <button class="increase-quantity" data-product-id="${productId}">+</button>
            </div>
            <button class="remove-from-cart" data-product-id="${productId}">&times;</button>
        `;

        // Add the new cart item to the cartItems div
        cartItems.appendChild(cartItem);
    }

    // Update the cart total and item count
    updateCartTotal();
    updateCartCount();
    saveCartToLocalStorage();
}

function updateCartTotal() {
    let total = 0;
    document.querySelectorAll('.cart-item').forEach(item => {
        const price = parseFloat(item.querySelector('.cart-item-price').textContent.replace('$', ''));
        const quantity = parseInt(item.querySelector('.cart-item-quantity').textContent);
        total += price * quantity;
    });
    cartTotal.textContent = `$${total.toFixed(2)}`;
}

function updateCartCount() {
    let itemCount = 0;
    document.querySelectorAll('.cart-item-quantity').forEach(quantityElem => {
        itemCount += parseInt(quantityElem.textContent);
    });
    cartCount.textContent = itemCount;
}

// Save cart to localStorage
function saveCartToLocalStorage() {
    const cart = [];
    document.querySelectorAll('.cart-item').forEach(item => {
        const productId = item.getAttribute('data-product-id');
        const productName = item.querySelector('.cart-item-name').textContent;
        const productPrice = parseFloat(item.querySelector('.cart-item-price').textContent.replace('$', ''));
        const productQuantity = parseInt(item.querySelector('.cart-item-quantity').textContent);
        const productImage = item.querySelector('.cart-item-image').src;

        cart.push({
            productId,
            productName,
            productPrice,
            productQuantity,
            productImage
        });
    });
    localStorage.setItem('cart', JSON.stringify(cart));
}

// Load cart from localStorage
function loadCartFromLocalStorage() {
    const cart = JSON.parse(localStorage.getItem('cart'));
    if (cart && cart.length > 0) {
        cart.forEach(item => {
            addToCart(item.productId, item.productName, item.productPrice, item.productImage);
            document.querySelector(`.cart-item[data-product-id="${item.productId}"] .cart-item-quantity`).textContent = item.productQuantity;
        });
        updateCartTotal();
        updateCartCount();
    }
}

// Remove item from cart
cartItems.addEventListener('click', function (e) {
    if (e.target.classList.contains('remove-from-cart')) {
        e.target.parentElement.remove();
        updateCartTotal();
        updateCartCount();
        saveCartToLocalStorage();
    }
});

// Increase or decrease item quantity
cartItems.addEventListener('click', function (e) {
    const productId = e.target.getAttribute('data-product-id');
    const cartItem = document.querySelector(`.cart-item[data-product-id="${productId}"]`);
    if (e.target.classList.contains('increase-quantity')) {
        const quantityElem = cartItem.querySelector('.cart-item-quantity');
        const newQuantity = parseInt(quantityElem.textContent) + 1;
        quantityElem.textContent = newQuantity;
    } else if (e.target.classList.contains('decrease-quantity')) {
        const quantityElem = cartItem.querySelector('.cart-item-quantity');
        const newQuantity = parseInt(quantityElem.textContent) - 1;
        if (newQuantity > 0) {
            quantityElem.textContent = newQuantity;
        } else {
            cartItem.remove();
        }
    }

    // Update the cart total and item count
    updateCartTotal();
    updateCartCount();
    saveCartToLocalStorage();
});

function isLogIn() {
    // Store the intended destination in localStorage
    localStorage.setItem('redirect_after_login', '/themes/checkout.html');
    
    // Call the authentication check
    checkAuthStatusForCheckout();
}

function checkAuthStatusForCheckout() {
    fetch('js/api/auth_status.php')
        .then(response => response.json())
        .then(data => {
            if (data.isLoggedIn) {
                window.location.href = '/themes/checkout.html';
            } else {
                alert("Please log in to proceed with the checkout.");
                const currentUrl = encodeURIComponent('/themes/checkout.html');
                window.location.href = `/themes/login.php?redirect_to=${currentUrl}`;
            }
        })
        .catch(error => console.error('Error:', error));
}
function proceedToCheckout() {
    // Proceed to checkout (this function may not be needed as it's already handled by the logic in login.php)
    window.location.href = '/themes/checkout.html'; // Redirect to the checkout page
}

