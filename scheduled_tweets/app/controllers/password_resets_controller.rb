class PasswordResetsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:email])

        if @user.present?
            #send email
            PasswordMailer.with(user: @user).reset.deliver_now
        else
            redirect_to root_path, notice: "If an account with that email was found, we have sent a link to reset your password"
        end
    end

    def edit 
        @user = User.find_signed(params[:token], purpose: "password_reset")
        rescue ActiveSuport::MessageVerifier::InvalidSignature
            redirect_to sign_in_path, alert: "Your token has expired, Please try again."
    end

    def update
        @user = User.find_signed(params[:token], purpose: "password_reset")
        if @user.update(password_params)
            redirect_to sign_in_path, notice: "Your password was reset successfuly. please signed in."
        else
            render :edit, status: :unprocessable_entity, content_type: "text/html"
            headers["Content-Type"] = "text/html"
        end
    end

    private 
    
    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end