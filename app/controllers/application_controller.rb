class ApplicationController < ActionController::API

    def authenticate
        authorization_header = request.headers["Authorization"]

        if authorization_header
            token = authorization_header.split(" ")[1]
            begin
                secret = Rails.application.secrets.secret_key_base
                
                # @user_id = JWT.decode(token, secret)[0]["user_id"]
                decoded_token = JWT.decode(token, secret)
                payload = decoded_token[0]
                @user_id = payload["user_id"]
            rescue
                render json: {message: "nice try asshole"}, status: :unauthorized
            end
        else
            render json: {message: "nice try asshole"}, status: :unauthorized
        end
    end

    def create_token(user)
        payload = { user_id: user.id }
        secret = Rails.application.secrets.secret_key_base
        JWT.encode(payload, secret)
    end

end
