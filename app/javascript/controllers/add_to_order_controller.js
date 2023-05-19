// app/javascript/controllers/add_to_order.js

import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = ["productId"];
  
  connect() {    
    if(!this.hasUploadDataFileTarget || document.documentElement.hasAttribute("data-turbolinks-preview")) {
      return
    }
    // Set up event listener for the button
    this.element.addEventListener("click", this.addToOrder.bind(this), { once: true });
  }

  addToOrder(event) {    
    event.stopPropagation();
    event.preventDefault();
    const productId = this.productIdTarget.value;
    if (confirm("Are you sure you want to add this item to  your order?")) {
         // Remove the event listener after confirmation
        this.element.removeEventListener("click", this.addToOrder.bind(this));

      $.ajax({
        url: `products/${productId}/add_to_order`,
        method: "POST",
        dataType: "json",
        headers: {
          "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
        },
        success: (data) => {
          // Handle the response data if needed
          $('.order-items-count').text(data.items_count);
          $('.order-total').text( numberToCurrency(data.total_price) );
          const buttonHTML = generateRemoveButton(productId);
          // Replace the HTML content of the container element
          const container = document.getElementById(`cart-button-product-${productId}`);
          container.innerHTML = buttonHTML;
        },
        error: (error) => {
          // Handle any errors that occur during the Ajax request
          console.error(error);
        },
      });
    }
  }
}

function generateRemoveButton(productId) {
  const button = document.createElement('button');
  button.id = `remove-from-order-button-product-${productId}`;
  button.className = 'add-to-order-button';
  button.setAttribute('data-controller', 'remove-from-order');
  button.setAttribute('data-remove-from-order-target', 'productId');
  button.value = productId;
  button.setAttribute('data-action', 'click->remove-from-order#removeFromOrder');
  button.setAttribute('data-product-id', productId);
  button.textContent = 'Remove from Order';

  return button.outerHTML;
}