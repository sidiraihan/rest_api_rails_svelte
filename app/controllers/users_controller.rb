class UsersController < ApplicationController
    before_action :authorized, only: [:auto_login, :test, :list_users]


    def create
        @user = User.create(user_params)
        if @user.valid?
            token = encode_token({user_id: @user.id})
            render json: {user: @user, token: token}
        else
            render json: {error: "invalid username or password"}
        end    
    end    

    def login
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            token = encode_token({user_id: @user.id})
            render json: {user: @user, token: token}
        else
            render json: {error: "invalid username or password"}
        end  
    end
    
    def auto_login
        render json: {user: @user, status: "success"}
    end

    def test
        render json: {status: "success"}
    end

    def list_users
        render json: User.all
    end
    
    def user_params
        params.permit(:username, :password, :age)
    end    

end
