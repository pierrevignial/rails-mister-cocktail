# frozen_string_literal: true

class DosesController < ApplicationController
  def index; end

  def new
    @dose = Dose.new
    @ingredient = Ingredient.new
  end

  def create
    @cocktail = Cocktail.find(params[:id])

    @ingredient = if (Ingredient.find_by name: tretm(dose_params[:ingredient][:name])).nil?
                    Ingredient.new(name: tretm(dose_params[:ingredient][:name]))
                  else
                    Ingredient.find_by name: tretm(dose_params[:ingredient][:name])
                  end
    @ingredient.save

    @dose = Dose.new({description: dose_params[:description].downcase, ingredient: @ingredient, cocktail: @cocktail})
    @dose.save

    @cocktail.save

    redirect_to cocktail_path(@cocktail)
  end

  def show; end

  def edit; end

  def update; end

  def destroy
    @dose = Dose.find(params[:id])
    @cocktail = @dose.cocktail
    @dose.destroy
    redirect_to update_cocktail_path(@cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, ingredient: {})
  end

  def tretm(string)
    arrayb = string.split(' ')
    arrayb.map!(&:capitalize)
    arrayb.join(' ')
  end
end
