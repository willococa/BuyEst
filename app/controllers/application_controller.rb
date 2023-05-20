class ApplicationController < ActionController::Base
    include ApplicationHelper    
    before_action :set_paper_trail_whodunnit
    
    rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_path, alert: 'Access denied.'
    end
end
