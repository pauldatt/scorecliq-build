class CategoriesController < ApplicationController
    before_action :logged_in_user
    before_action :private_entry, only: [:index, :show]
    
    def index 
        @selected = true 
        @leaguedocs = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @category = Category.new
        @categories = @scoreboard.categories
        @document = Document.new
    end
    
    def new 
        @selected = true
        @leaguedocs = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @category = Category.new
    end
    
    
    def create 
       @scoreboard = Scoreboard.find(params[:scoreboard_id])
       @category = @scoreboard.categories.build(category_params)
       if (@scoreboard.categories.count < 10 )
           if @category.save 
               flash[:success] = "Category has been created."
               redirect_to scoreboard_categories_path(@scoreboard)
           else
               flash[:danger] = "Category could not be created successfully."
               redirect_to scoreboard_categories_path(@scoreboard)
           end
       else
           flash[:danger] = "Only 10 categories can be created per league."
           redirect_to scoreboard_categories_path(@scoreboard)
       end
    end
    
    def show
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @category = @scoreboard.categories.find(params[:id])
        @document = Document.new
        @documents = @category.documents
        @selected = true
        @leaguedocs = true
    end
    
    def edit
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @category = @scoreboard.categories.find(params[:id])
    end
    
    def update 
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @category = @scoreboard.categories.find(params[:id])
        if  @category.update_attributes(category_params)
            flash[:success] = "Category name changed"
            redirect_to scoreboard_categories_path(@scoreboard)
        else
            flash[:danger] = "Category name change unsuccessful"
            redirect_to scoreboard_categories_path(@scoreboard)
        end
    end
    
    def destroy
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @category = Category.find(params[:id])
        @category.destroy
        flash[:success] = "Category was deleted successfully"
        redirect_to scoreboard_categories_path(@scoreboard)
    end
        
    private
    
    def category_params
       params.require(:category).permit(:name)
    end
    
    def private_entry
     @scoreboard = Scoreboard.find(params[:scoreboard_id])
     if privacy_restriction?(@scoreboard, current_user)
       redirect_to scoreboard_path(@scoreboard)
       flash[:danger] = "Private League. You must make a request to join before accessing league pages."
     end
    end
    
    
    
    
        
end
