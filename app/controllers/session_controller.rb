class SessionController < ApplicationController
    before_action :set_user,only: [:create]

    def new
        
    end
    def create

        if @user.authenticate(session_params[:password])
            login(@user)
            redirect_to root_path
        else
            render 'ligin' ,status: :unprocessable_entity
        end
    end



    def set_user
        @user = User.find_by!(mail: session_params[:email])
    rescue
        flash.now[:danger] = t('.flash.invalid_mail')
        render 'login'
    end
end
