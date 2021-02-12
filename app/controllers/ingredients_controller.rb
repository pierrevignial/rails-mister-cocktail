# frozen_string_literal: true

class IngredientsController < ApplicationController
  def index; end

  def new; end

  def create
    @ingredient = ingredient.new(ingredient_params)
    @ingredient.save

    redirect_to cocktail_path(@ingredient.cocktail)
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

  def ingredient_params
    params.require(:doses).permit(:ingredient).permit(:name)
  end
end
