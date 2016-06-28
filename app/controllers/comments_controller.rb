class CommentsController < ApplicationController

before_action :logged_in_user


def new
 @scoreboard = Scoreboard.find(params[:scoreboard_id])
 @topic = Topic.find(params[:topic_id])
 @comment = @topic.comments.new  :parent_id => params[:parent_id]
end

def create
 @scoreboard = Scoreboard.find(params[:scoreboard_id])
 @topic = Topic.find(params[:topic_id])
 @comment = @topic.comments.build(comment_params)
  if @comment.save
     redirect_to scoreboard_topic_path(@scoreboard,@topic)
     flash[:success] = "Comment posted successfully"
  else
    redirect_to scoreboard_topic_path(@scoreboard,@topic)
    flash[:danger] = 'Comment cannot be blank and must be less than 600 characters'
  end
end

def destroy
 @scoreboard = Scoreboard.find(params[:scoreboard_id])
 @topic = Topic.find(params[:topic_id])
 @comment = Comment.find(params[:id])
 @comment.destroy
 redirect_to scoreboard_topic_path(@scoreboard, @topic)
end


private
 

 def comment_params
  params.require(:comment).permit(:body, :parent_id).merge(user_id: current_user.id) #the merge function allows each comment ot be associated with the user
 end

end
