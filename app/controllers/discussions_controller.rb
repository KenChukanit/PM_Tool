class DiscussionsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user_discussion!, only: [:edit, :update, :destroy]
    def create
        @project = Project.find params[:project_id]
        @discussion = Discussion.new discussion_params
        @discussion.project = @project
        @discussion.user = current_user
        
        if @discussion.save
            redirect_to project_path(@project), notice: 'New Dicussion created'
        else   
            render :new
        end

    end

    def new
        @project = Project.find params[:project_id]
        @discussion = Discussion.new
        
    end

    def destroy
        @project = Project.find params[:project_id]
        @discussion = Discussion.find params[:id]
        @discussion.destroy
        redirect_to project_path(@project), notice: "Dicussion deleted"
    end

    def edit
        @project = Project.find params[:project_id]
        @discussion = Discussion.find params[:id]
    end

    def update
        @project = Project.find params[:project_id]
        @discussion = Discussion.find params[:id]

        if @discussion.update discussion_params
        redirect_to project_path(@project.id), notice: "You have updated the discussion."
        else  
            render :edit
        end
    end

    private
    def discussion_params
        params.require(:discussion).permit(:title, :description)
    end

    def authorize_user_discussion!
        @discussion = Discussion.find params[:id]
        redirect_to projects_path, alert: "!Only Authorized User can make a change"unless can?(:crud, @discussion)
    end
end
