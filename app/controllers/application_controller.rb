class ApplicationController < ActionController::Base
    # to authorize user before every action on the application
    before_action :authorize

    protected
        def authorize
            # check if user_id is set, and corresponds to a user in db 
            unless User.find_by(id: session[:user_id])
                redirect_to login_url, notice: 'Please log in'
            end
        end
end
