import { Application } from "@hotwired/stimulus"
import RemoveFromOrderController from "./remove_from_order_controller.js"
import AddToOrderController from "./add_to_order_controller.js"
const application = Application.start()
// Define the numberToCurrency function as a global function
window.numberToCurrency = function(number) {
    return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(number);
  }
  
application.register("remove-from-order", RemoveFromOrderController)
application.register("add-to-order", AddToOrderController)
// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
  
export { application }
