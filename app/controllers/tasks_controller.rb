class TasksController < ApplicationController

    before_action :authenticate_user!
    
    def create
        @project = Project.find params[:project_id]
        @task = Task.new task_params
        @task.project = @project
        
        if @task.save
            redirect_to project_path(@project), notice: 'Task created'
        else   
            render 'projects/show'
        end

    end

    def destroy
        @project = Project.find params[:project_id]
        @task = Task.find params[:id]
        @task.destroy
        redirect_to project_path(@project), notice: "Task deleted"
    end

    def update
        @project = Project.find params[:project_id]
        @task = Task.find params[:id]
    
        if @task.uncompleted?
            @task.completed!
            redirect_to project_path(@project), notice: 'Task completed'
        else   

            @task.uncompleted!
            redirect_to project_path(@project), notice: 'Changed this task to undone'
        end
    end

    private
    def task_params
        params.require(:task).permit(:title, :body, :due_date)
    end
end
