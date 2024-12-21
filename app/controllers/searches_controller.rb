class SearchesController < ApplicationController
  
  #items_controllerに記載
  def keyword_search
    @genres = Genre.all
    @keyword = params[:keyword].to_s.strip.gsub(/[\s　]+/, " ")
    if @keyword.present?
      @items = Item.search_by_keyword(@keyword).page(params[:page]).per(8)
    else
      redirect_to root_path
    end
  end

  def genre_search
    @genre_id = params[:genre_id]
    @genre = Genre.find(@genre_id)
    @genres = Genre.all
    @items = Item.where(genre_id: @genre_id).page(params[:page]).per(8)
  end

end