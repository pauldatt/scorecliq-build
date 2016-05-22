class CategoriesController < ApplicationController
    before_action :logged_in_user
    
    def index 
        @selected = true 
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @category = @scoreboard.categories
        @document = Document.new
    end
    
    def new 
        @selected = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @category = Category.new
    end
    
    
    def create 
       @scoreboard = Scoreboard.find(params[:scoreboard_id])
       @category = @scoreboard.categories.build(category_params)
       if @category.save 
           flash[:notice] = "created successfully"
           redirect_to scoreboard_categories_path(@scoreboard)
       else
           flash[:notice] = "not created"
           redirect_to scoreboard_categories_path(@scoreboard)
       end
    end
    
    def update 
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @category = @scoreboard.category.find(params[:id])
        @category.update_attributes(category_params)
        if @category.update 
            flash[:success] = "updated successfully"
            redirect_to scoreboard_categories_path(@scoreboard)
        else
            flash[:danger] = "could not update"
            redirect_to scoreboard_categories_path(@scoreboard)
        end
    end
    
    def destroy
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @category = Category.find(params[:id])
        @category.destroy
        flash[:success] = "deleted successfully"
        redirect_to scoreboard_categories_path(@scoreboard)
    end
        
    private
    
    def category_params
       params.require(:category).permit(:name)
    end
    
    
    
    
        
end
