class SessionsController < ApplicationController
    def create
        user = User.find_by_username(params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user
        else 
            render json: {error: "Invalid username or password"}, status: :unauthorized
        end
    end

    def destroy
        user = User.find_by_username(params[:username])
        session.delete :user_id
        head :no_content
    end
end
