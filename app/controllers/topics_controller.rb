class TopicsController < ApplicationController
    
    def index 
        @selected = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @topics = @scoreboard.topics
    end
    
    def new 
        @selected = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @topic = Topic.new
        @comment = @topic.comments.build
    end
    
    def create 
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @topic = @scoreboard.topics.build(topic_params)
        if @topic.save
            redirect_to scoreboard_topics_path(@scoreboard)
            flash[:success] = "Topic created successfully."
        else
            redirect_to new_scoreboard_topic_path(@scoreboard)
            flash[:danger] = "Error. Please refresh page and try again."
        end
    end
    
    def show
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @topic = Topic.find(params[:id])
        @tools = @topic.comments.no_ancestry
        @comments = @tools.paginate(page: params[:page], per_page: 15)
        @comment = @topic.comments.build
        @selected = true
    end
    
    def destroy 
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @topic = Topic.find(params[:id])
        @topic.destroy
        flash[:success] = "Topic destroyed"
        redirect_to scoreboard_topics_path(@scoreboard)
    end
    
    private 
    
    def topic_params
        params.require(:topic).permit(:subject, comments_attributes: [:body, :user_id]).merge(user_id: current_user.id)
    end
    
    
end
