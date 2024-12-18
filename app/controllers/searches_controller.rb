class SearchesController < ApplicationController
  
  #items_controllerに記載
  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @keyword = params[:post][:search] if params[:post]
    @posts_all = Post.search(@keyword)
    @posts = Kaminari.paginate_array(@posts_all).page(params[:page]).per(10)
  end

  def genre_search
    @genre_id = params[:genre_id]
    @genre = Genre.find(@genre_id)
    @genres = Genre.all
    @items = Item.where(genre_id: @genre_id).page(params[:page]).per(8)
  end

end