class UsersController < ApplicationController
    before_action :require_logged_in, only: [:index,:show,:edit,:update,:delete]

    def new 
        @user = User.new
        render :new
    end

    def edit 
        @user = User.find(params[:id])
        render :edit
    end

    def index
        @users = User.all # get all users from DB and store in users variable
        # every controller action needs to either render or redirect
        # render json: users # rails will turn our users into json
        render :index
    end

    def show
        # just one user
        @user = User.find(params[:id])
        # render json: user
        render :show
        # not necessary - implicit render of the same action name
    end

    def create
        # debugger
        # user = User.new(
        #     email: params[:email],
        #     username: params[:username],
        #     age: params[:age],
        #     political_affiliation: params[:political_affiliation]
        #     # tedious
        # )
        @user = User.new(user_params)
        # creates user instance not in DB
        if @user.save
            # Eventually we will want to log in the user when we create them
            # render json: user
            # redirect_to "/users/#{user.id}" # redirects to show action
            redirect_to user_url(@user)
            # creates another HTTP request 
        else
            # render json: user.errors.full_messages, status: 422 # unprocesable entity
            render :new
            # points to view
        end
    end

    def update
        @user = User.find(params[:id]) # find the user
        if @user.update(user_params)
            # redirect_to "/users/#{user.id}"
            redirect_to user_url(@user)
        else
            render json: @user.errors.full_messages, status: 422
        end
    end

    def destroy
        debugger
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_url
        # render json: user
    end

    private

    def user_params
        params.require(:user).permit(:age,:username,:email,:political_affiliation,:password)
    end
end
