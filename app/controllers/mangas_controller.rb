class MangasController < ApplicationController
  def index
    @mangas = Manga.all
  end

  def show
    @manga = Manga.find(params[:id])
  end

  def search_results
    @query = params[:query]
    @mangas = Manga.where("title LIKE ?", "%#{@query}%")
  end
end
