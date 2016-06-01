class TopicsController < ApplicationController
    
    def index 
        @selected = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @topic = @scoreboard.topics
    end
    
    def new 
        @selected = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @topic = Topic.new
    end
    
    def create 
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @topic = @scoreboard.topics.build(topic_params)
        if @topic.save
            redirect_to scoreboard_topics_path(@scoreboard)
            flash[:success] = "topic created"
        else
            redirect_to new_scoreboard_topic_path(@scoreboard)
            flash[:danger] = "topic could not be created"
        end
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
        params.require(:topic).permit(:subject).merge(user_id: current_user.id)
    end
    
    
end
