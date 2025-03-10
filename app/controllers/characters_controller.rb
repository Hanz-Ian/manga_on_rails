class CharactersController < ApplicationController
  def show
    @character = Character.find(params[:id])
    @manga = @character.manga
  end
end
