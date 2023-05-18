// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
$(document).on('turbo:load', function(){
    
    function addToOrder(product){
        $(".product-list").append("<li class='product-item'>Product " + product + "</li>");
    }
    $(".add-product-to-order").on("click", function(){
        addToOrder($(this).data("product-id"));
    });
});
