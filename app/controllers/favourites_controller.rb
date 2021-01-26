class FavouritesController < ApplicationController

    def index
        @favourites = current_user.favoured_projects.order(created_at: :desc)
        
    end

    def create
        project = Project.find params[:project_id]
        favourite = Favourite.new user: current_user, project: project
        if !can?(:favourite, project)
            flash[:alert] = "You can't favourite your own project"
        elsif favourite.save
            flash[:success] = "Project favourited!"
            redirect_to project
        else
            flash[:warning] = favourite.errors.full_messages.join(', ')
        end
    end

    def destroy
        @favourite = Favourite.find params[:id]
        if can? :destroy, @favourite
            @favourite.destroy
            flash[:success] = "Unfavourited Review"
            redirect_to @favourite.project
        else 
            flash[:alert] = "Could not favourite review"
            redirect_to @favourite.project
        end
    end
end