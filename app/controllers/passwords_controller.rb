class PasswordsController < ApplicationController

    def edit
        @user = current_user
        @password = @user.password_digest
       
    end

    def update
        @old_password = params[:old_password]
        @new_password = params[:new_password]
        @new_password_confirmation = params[:new_password_confirmation]
        @user = current_user
        if @old_password == user.password_digest
            @user.update(password_digest: @new_password, password_confirmation: @new_password_confirmation)
            redirect_to root_path , notice: "You have changed your password"
        
                render :edit
                
        else  
            render :edit, alert: "Wrong password!  Please check your password"
        end
    end

    private
    def user_params
        params.require(:user).permit(:password_digest)
    end
end
