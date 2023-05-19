import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["productId"];
  
  connect() {    
    if(!this.hasUploadDataFileTarget || document.documentElement.hasAttribute("data-turbolinks-preview")) {
      return
    }
    this.element.addEventListener("click", this.removeFromOrder.bind(this), { once: true });
  }
  removeFromOrder(event) {
    event.stopPropagation();
    event.preventDefault();
    const productId = this.productIdTarget.value;

    if (confirm("Are you sure you want to remove this item from your order?")) {

      $.ajax({
        url: `/products/${productId}/remove_from_order`,
        method: "DELETE",
        dataType: "json",
        headers: {
          "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
        },
        success: (data) => {
          // Handle the response data if needed
          console.log(data);
          $('.order-items-count').text(data.items_count);
          $('.order-total').text(numberToCurrency(data.total_price));
          const buttonHTML = generateAddButton(productId);
          
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
function generateAddButton(productId) {
  const button = document.createElement('button');
  button.id = `add-to-order-button-product-${productId}`;
  button.className = 'add-to-order-button';
  button.setAttribute('data-controller', 'add-to-order');
  button.setAttribute('data-add-to-order-target', 'productId');
  button.value = productId;
  button.setAttribute('data-action', 'click->add-to-order#addToOrder');
  button.setAttribute('data-product-id', productId);
  button.textContent = 'Add to Order';

  return button.outerHTML;
}