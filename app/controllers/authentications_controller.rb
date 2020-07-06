class AuthenticationsController < ApplicationController

    def login
        @user = User.find_by(username: params[:username])

        if @user

            if @user.authenticate(params[:password])
                token = create_token(@user)

                render json: {token: token}
            else
                render json: {message: "nice try asshole!!!"}, status: :unauthorized
            end
        else
            render json: {message: "nice try asshole"}, status: :unauthorized
        end
    end
    
end
