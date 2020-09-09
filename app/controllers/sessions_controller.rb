class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        @user = User.find_by_credentials( # was defined in User model
            params[:user][:username], 
            params[:user][:password]
        )
        if @user
            login!(@user)
            redirect_to user_url(@user)
        else
            # flash.now[:errors] = @user.errors.full_messages
            # cant use errors.full_messages because @user is nil
            # render :new
            flash[:errors] = ['Username or password is incorrect, please try again']
            redirect_to new_session_url
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end
end
