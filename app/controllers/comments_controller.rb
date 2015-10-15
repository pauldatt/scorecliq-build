class CommentsController < ApplicationController
    
    def new
     @scoreboard = Scoreboard.find(params[:scoreboard_id])
     @comment = @scoreboard.comments.new(:parent_id => params[:parent_id])
    end
   
    
    def create
     @scoreboard = Scoreboard.find(params[:scoreboard_id])
     @comment = @scoreboard.comments.new comment_params
     if @comment.save
         redirect_to scoreboard_url(@comment.scoreboard_id) 
     else
       render 'new'
     end
    end
    
    def edit
    end
    
    def update
    end 
    
    def destroy
    end

    
    private
    
     def comment_params
      params.require(:comment).permit(:body, :parent_id).merge(user_id: current_user.id)
     end

end
