

module Auth
    def signed_in?
        return true if session[:user_id]

        false
    end

    def me
        session[:user_id]
    end
end