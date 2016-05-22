class DocumentsController < ApplicationController
  before_action :logged_in_user
    
    def new 
        @selected = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @category = Category.find(params[:category_id])
        @document = Document.new
    end
    
    def create 
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @category = Category.find(params[:category_id])
        @document = @category.documents.build(document_params)
        if @document.save
            flash[:success] = "uploaded successfully"
            redirect_to scoreboard_categories_path(@scoreboard)
        else
            flash[:danger] = "failed to upload"
            redirect_to scoreboard_categories_path(@scoreboard)
        end
    end
    
    def update 
        @category = Category.find(params[:category_id])
        @document = Document.find(params[:id])
        if @document.update_attributes(document_params) 
            flash[:success] = "updated successfully"
            redirect_to @category
        else
            flash[:danger] = "did not update" 
            redirect_to @category
        end
    end
    
    def destroy
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @document = Document.find(params[:id])
        @document.destroy
        flash[:success] = "destroyed successfully"
        redirect_to scoreboard_categories_path(@scoreboard)
    end
        
    
    private
    
    def document_params 
        params.require(:document).permit(:file, :file_name)
    end
    
end