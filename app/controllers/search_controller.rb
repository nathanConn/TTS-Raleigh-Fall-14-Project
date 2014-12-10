class SearchController < ApplicationController
  def search
  	@searchs = Search.search
  	params[:search]
  end
end
