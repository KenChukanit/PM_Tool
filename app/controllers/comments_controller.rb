class CommentsController < ApplicationController

   
    def create
        @project = Project.find params[:project_id]
        @discussion = Discussion.find params[:discussion_id]
        @comment = Comment.new comment_params
        @task = Task.new
        @comment.discussion = @discussion
        
        if @comment.save
            redirect_to project_path(@project), notice: 'New Comment created'
        else   
            render 'projects/show'
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
        @comment = Comment.new comment_params

        @comment.destroy
        redirect_to project_path(@project), notice: "Comment deleted"
    end

    def edit
       
    end

    def update
        @project = Project.find params[:project_id]
        @discussion = Discussion.find params[:discussion_id]
        @comment = Comment.new comment_params
        
        if @comment.update comment_params
        redirect_to project_path(@project.id), notice: "You have updated the discussion."
        else  
            render :edit
        end
    end

    private

    def find_dicussion_comment
        @project = Project.find params[:project_id]
        @discussion = Discussion.find params[:discussion_id]
        @comment = Comment.new comment_params
    end

    def comment_params
        params.require(:comment).permit(:body)
    end

end
