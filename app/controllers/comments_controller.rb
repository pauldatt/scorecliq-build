class CommentsController < ApplicationController
 
def new
 @scoreboard = Scoreboard.find(params[:scoreboard_id])
 @comment = @scoreboard.comments.new  :parent_id => params[:parent_id]
end

def create
 @scoreboard = Scoreboard.find(params[:scoreboard_id])
 @comment = @scoreboard.comments.build(comment_params)
 respond_to do |format|
  if @comment.save
    format.html { redirect_to scoreboard_url(@comment.scoreboard_id) }
  else
   format.html { 
    redirect_to scoreboard_url(@comment.scoreboard_id)
    flash[:danger] = 'Comment cannot be blank and must be less than 140 characters'
   }
  end
 end
end

def destroy
 @comment = Comment.find(params[:id])
 @comment.destroy
 redirect_to scoreboard_url(@comment.scoreboard_id)
end


private

 def comment_params
  params.require(:comment).permit(:body, :parent_id).merge(user_id: current_user.id) #the merge function allows each comment ot be associated with the user
 end

end
