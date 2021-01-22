class UsersController < ApplicationController
    def new
        @user=User.new
    end
    def create
        @user=User.new user_params
        if @user.save
            session[:user_id]=@user.id
            redirect_to root_path, notice: "Logged in!"
        else
            render :new
        end
    end
    
    def edit
        @user = User.find params[:id]
    end

    def update
        @user = User.find params[:id]
        
        if @user.update user_params
        redirect_to root_path , notice: "You have updated your profile"
        else  
            render :edit
        end
    end

    def change_password
    end

    def do_reset_password
        id = params[:id]
        
        if params[:user][:new_password] != params[:user][:new_password_confirmation]
            flash[:alert] = "Passwords must match." 
            redirect_to user_change_password_path(@user)
            return
        end
        if  @user.authenticate(params[:user][:new_password])  == @user.authenticate(params[:password])
            @user.update(password: params[:user][:new_password],
                        password_confirmation: params[:user][:new_password_confirmation] )
            @user.save
            respond_to do |format|
                format.html { redirect_to root_path, notice: 'Your password has been changed.' }
            end
        else
            flash[:alert] = "Invalid password, must be at least 6 charactors." 
            redirect_to user_change_password_path(@user)
        end
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
