class SearchController < ApplicationController
  
  #items_controllerに記載
  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @keyword = params[:post][:search] if params[:post]
    @posts_all = Post.search(@keyword)
    @posts = Kaminari.paginate_array(@posts_all).page(params[:page]).per(10)
  end
