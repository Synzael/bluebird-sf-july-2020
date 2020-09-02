class UsersController < ApplicationController
    def index
        users = User.all # get all users from DB and store in users variable
        # every controller action needs to either render or redirect
        render json: users # rails will turn our users into json
    end

    def show
        # just one user
        user = User.find(params[:id])
        render json: user
    end

    def create
        # user = User.new(
        #     email: params[:email],
        #     username: params[:username],
        #     age: params[:age],
        #     political_affiliation: params[:political_affiliation]
        #     # tedious
        # )
        user = User.new(user_params)
        # creates user instance not in DB
        if user.save
            # render json: user
            # redirect_to "/users/#{user.id}" # redirects to show action
            redirect_to user_url(user)
        else
            render json: user.errors.full_messages, status: 422 # unprocesable entity
        end
    end

    def update
        user = User.find(params[:id]) # find the user
        if user.update(user_params)
            # redirect_to "/users/#{user.id}"
            redirect_to user_url(user)
        else
            render json: user.errors.full_messages, status: 422
        end
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
        render json: user
    end

    private

    def user_params
        params.require(:user).permit(:age,:username,:email,:political_affiliation)
    end
end
