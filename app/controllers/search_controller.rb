class SearchController < ApplicationController

before_action :logged_in_user, only: :index

def index
    @pg_search_documents = PgSearch.multisearch(params[:search]).paginate(:page => params[:page], :per_page => 10)
end

end
