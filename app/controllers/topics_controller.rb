class TopicsController < ApplicationController
    before_action :logged_in_user
    before_action :private_entry, only: [:index, :new, :show]
    
    def index 
        @selected = true
        @leaguetalk = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @topics = @scoreboard.topics.paginate(page: params[:page], per_page: 10)
    end
    
    def new 
        @selected = true
        @leaguetalk = true 
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
            flash[:danger] = "Error. Please try again."
        end
    end
    
    def show
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @topic = Topic.find(params[:id])
        @parentless = @topic.comments.no_ancestry
        @comments = @parentless.paginate(page: params[:page], per_page: 15)
        @comment = @topic.comments.build
        @selected = true
        @leaguetalk = true 
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
    
    def private_entry
     @scoreboard = Scoreboard.find(params[:scoreboard_id])
     if privacy_restriction?(@scoreboard, current_user)
       redirect_to scoreboard_path(@scoreboard)
       flash[:danger] = "Private League. You must make a request to join before accessing league pages."
     end
    end
    
    
end
