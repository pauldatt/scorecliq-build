class StatusesController < ApplicationController
before_action :logged_in_user  
      
    def update
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @status = @scoreboard.status
        respond_to do |format|
          if @status.update_attributes(status_params)
                format.html {redirect_to(@scoreboard)}
                format.json {respond_with_bip(@status)}
            else
                # format.html {render 'scoreboard/show'}
                format.json {respond_with_bip(@status)}
          end
        end
    end
            
private

    def status_params
        params.require(:status).permit(:content)
    end

end