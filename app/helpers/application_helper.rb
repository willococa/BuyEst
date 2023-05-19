module ApplicationHelper
    def current_order
        if client_signed_in?
            current_client.current_order
        end
    end
end
