class ProjectsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_project, only: [:show, :edit, :update, :destroy ]
    def index
        @projects = Project.all.order(created_at: :desc)
    end

    def show
        @tasks = @project.tasks.order(created_at: :desc)
        @task = Task.new
        @discussions = @project.discussions.order(created_at: :desc)
        # @discussion = Discussion.find params[:id]
        @discussion = Discussion.new
        @comments = @discussion.comments.order(created_at: :desc)
        @comment = Comment.new
     
    end

    def destroy
        @project.destroy
        redirect_to projects_path
    end

    def new
        @project = Project.new
    end

    def create  
        @project = Project.new project_params
        @project.user = current_user
        
        if @project.save
            flash[:notice] = "New project has been created"
            redirect_to project_path(@project.id)
        else  
            render :new
        end
    end

    def edit

    end

    def update
        if @project.update project_params
        redirect_to project_path(@project.id), notice: "You have updated the project."
        else  
            render :edit
        end
    end


    private
    def find_project
        @project = Project.find params[:id]
    end

    def project_params
        params.require(:project).permit(:title, :description, :due_date)
    end

end
