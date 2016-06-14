class DocumentsController < ApplicationController
  before_action :logged_in_user
  before_action :valid_document, only: :create
    
  
    
    def create 
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @category = Category.find(params[:category_id])
        @document = @category.documents.build(document_params)
        if @document.save
            flash[:success] = "Document uploaded successfully."
            redirect_to scoreboard_category_path(@scoreboard, @category) 
        else
            flash[:danger] = "Failed to Upload. Please check accepted file formats and try again."
            redirect_to scoreboard_category_path(@scoreboard, @category) 
        end
    end
    
    
    def destroy
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @category = Category.find(params[:category_id])
        @document = Document.find(params[:id])
        @document.destroy
        respond_to do |format|
                format.html {  redirect_to scoreboard_category_path(@scoreboard, @category) }
                format.js 
        end
    end
        
    
    private
    
    def document_params 
        params.require(:document).permit(:file, :file_name)
    end
    
    def valid_document
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @category = Category.find(params[:category_id])
        if params[:document]['file_name'].blank?
             flash[:danger] = "Please try again. File name can't be blank."
             redirect_to scoreboard_category_path(@scoreboard, @category)
        elsif params[:document]['file'].blank?
             flash[:danger] = 'Please try again. You must select a document for upload.'
             redirect_to scoreboard_category_path(@scoreboard, @category)
        end
    end
    
end