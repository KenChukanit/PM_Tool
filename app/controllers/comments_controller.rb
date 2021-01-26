class CommentsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user_comment!, only: [:edit, :update, :destroy]
   
    def create
        @task = Task.new
        @project = Project.find params[:project_id]
        @discussion = Discussion.find params[:discussion_id]
        @comment = Comment.new comment_params
        @comment.user = current_user
        @comment.discussion = @discussion
        
        
        if @comment.save
            redirect_to project_path(@project), notice: 'New Comment created'
        else   
            render :new
        end

    end

    def new
        @project = Project.find params[:project_id]
        @discussion = Discussion.find params[:discussion_id]
        @comment = Comment.new
        
    end

    def destroy
        @project = Project.find params[:project_id]
        @discussion = Discussion.find params[:discussion_id]
        @comment = Comment.find params[:id]

        if @comment.destroy
        redirect_to project_path(@project), notice: "Comment deleted"
        else  
            render project_path(@project)
        end
    end

    def edit
        @project = Project.find params[:project_id]
        @discussion = Discussion.find params[:discussion_id]
        @comment = Comment.find params[:id]
    end

    def update
        @project = Project.find params[:project_id]
        @discussion = Discussion.find params[:discussion_id]
        @comment = Comment.find params[:id]
        
        if @comment.update comment_params
        redirect_to project_path(@project.id), notice: "You have updated the comment."
        else  
            render :edit
        end
    end

    private

    def find_dicussion_comment
        @project = Project.find params[:project_id]
        @discussion = Discussion.find params[:discussion_id]
        @comment = Comment.find params[:id]
    end

    def comment_params
        params.require(:comment).permit(:body)
    end

    def authorize_user_comment!
        @project = Project.find params[:project_id]
        @discussion = Discussion.find params[:discussion_id]
        @comment = Comment.find params[:id]
        redirect_to projects_path, alert: "!Only Authorized User can make a change"unless can?(:crud, @comment)
    end
end
