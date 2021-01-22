class PasswordsController < ApplicationController

    # def new
    #     @user = current_user
    #     @password = @user.password_digest
    # end

    # def create
    #     @user = current_user
    #     @password = @user.password_digest
    #     @old_password = params[:user][:old_password]
    #     @new_password = params[:user][:new_password]
    #     @new_password_confirmation = params[:user][:new_password_confirmation]
        
    #     if params[:user][:old_password] == @user.password_digest
    #         @user.update(password_digest: @new_password, password_confirmation: @new_password_confirmation)
    #         redirect_to root_path , notice: "You have changed your password"
        
    #             render :edit
                
    #     else  
    #         render :edit, alert: "Wrong password!  Please check your password"
    #     end

    # end
    # def edit
        
    #     @user = current_user
    #     @password = @user.password_digest
       
    # end

    # def update
       
        # @current_user ||= User.find_by_id session[:user_id]

        # if @old_password == @current_user.password
        #     @user.update(password_digest: @new_password, password_confirmation: @new_password_confirmation)
        #     redirect_to root_path , notice: "You have changed your password"
        
        #         render :edit
                
        # else  
        #     render :edit, alert: "Wrong password!  Please check your password"
        # end
    # end

    private
    def user_params
        params.require(:user).permit(:password_digest)
    end
end
