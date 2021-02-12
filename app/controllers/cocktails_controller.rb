# frozen_string_literal: true

class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(name: tretm(cocktail_params[:name]))
    @cocktail.save

    redirect_to cocktail_path(@cocktail)
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def edit
    @cocktail = Cocktail.find(params[:id])
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    redirect_to cocktail_path(@cocktail)
  end

  def destroy; end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end

  def tretm(string)
    arrayb = string.split(' ')
    arrayb.map!(&:capitalize)
    arrayb.join(' ')
  end
end
