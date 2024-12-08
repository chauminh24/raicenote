// Existing loadCartItems function remains the same

// Add function to calculate total order amount
function calculateTotalAmount() {
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    return cart.reduce((total, item) => total + (item.productPrice * item.productQuantity), 0);
}

// Modify placeOrder function to validate and submit order
async function placeOrder(event) {
    event.preventDefault();

    // Get form input values
    const fullName = document.getElementById('fullName').value.trim();
    const address = document.getElementById('address').value.trim();
    const city = document.getElementById('city').value.trim();
    const postalCode = document.getElementById('postalCode').value.trim();
    const country = document.getElementById('country').value.trim();

    // Basic validation
    if (!fullName || !address || !city || !postalCode || !country) {
        alert('Please fill in all shipping information fields.');
        return;
    }

    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    if (cart.length === 0) {
        alert('Your cart is empty.');
        return;
    }

    const totalAmount = calculateTotalAmount();
    const trackingNumber = generateTrackingNumber();

    // Prepare order data
    const orderData = {
        fullName,
        address,
        city,
        postalCode,
        country,
        totalAmount,
        trackingNumber,
        items: cart
    };

    try {
        const response = await fetch('js/api/process_order.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(orderData)
        });

        const result = await response.json();

        if (result.success) {
            // Clear cart and redirect to confirmation page
            localStorage.removeItem('cart');
            window.location.href = 'order-confirmation.html?tracking=' + trackingNumber;
        } else {
            alert('Order processing failed: ' + result.message);
        }
    } catch (error) {
        console.error('Error:', error);
        alert('An error occurred while processing your order.');
    }
}

// Add event listener when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    const orderButton = document.getElementById('orderPlacingBtn');
    if (orderButton) {
        orderButton.addEventListener('click', placeOrder);
    }
    loadCartItems();
});
function loadCartItems() {
    const cart = JSON.parse(localStorage.getItem('cart'));
    const cartItemsContainer = document.getElementById('cartItemsContainer');
    
    cartItemsContainer.innerHTML = ''; // Clear the container
    
    if (cart && cart.length > 0) {
        cart.forEach(item => {
            const cartItem = document.createElement('div');
            cartItem.classList.add('cart-item');
            cartItem.innerHTML = `
                <img src="${item.productImage}" alt="${item.productName}" class="cart-item-image">
                <div>
                    <h3>${item.productName}</h3>
                    <p>Price: $${item.productPrice.toFixed(2)}</p>
                    <p>Quantity: ${item.productQuantity}</p>
                    <p>Subtotal: $${(item.productPrice * item.productQuantity).toFixed(2)}</p>
                </div>
            `;
            cartItemsContainer.appendChild(cartItem);
        });
    } else {
        cartItemsContainer.innerHTML = '<p>Your cart is empty.</p>';
    }
}

function generateTrackingNumber() {
    return 'TRK-' + Math.random().toString(36).substr(2, 9).toUpperCase();
}

// Load cart items on page load
window.onload = loadCartItems;
