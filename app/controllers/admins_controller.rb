class AdminsController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_authorize!

    def index 
        @users = User.order(created_at: :desc)
        @projects = Project.order(created_at: :desc)
        @tasks = Task.order(created_at: :desc)
        @discussions = Discussion.order(created_at: :desc)
        @comments = Comment.order(created_at: :desc)
    end

    private

    def admin_authorize!
        redirect_to root_path, alert: 'Only Admin status is authorized!' unless current_user.is_admin?
    end

end
