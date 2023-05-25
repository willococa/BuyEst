module ApplicationHelper
    def current_order
        if client_signed_in?
            current_client.current_order
        end
    end

    def current_user
        if client_signed_in?
            current_client
        elsif admin_signed_in?
            current_admin
        else
            Guest.new
        end
    end
    class Guest
        attr_reader :role
    end
end
