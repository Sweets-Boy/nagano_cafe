class SearchController < ApplicationController
  
  def search
    @model = params[:model]
end
