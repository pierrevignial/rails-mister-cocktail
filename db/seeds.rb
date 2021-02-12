# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

def tretm(string)
  arrayb = string.split(' ')
  arrayb.map!(&:capitalize)
  arrayb.join(' ')
end

letterarray = ('a'..'z')
letterarray.each do |letter|
  drink_seed = JSON.parse(open("https://www.thecocktaildb.com/api/json/v1/1/search.php?f=#{letter}").read)['drinks']
  next if drink_seed.nil?

  drink_seed.each do |cocktail_hash|
    cocktail_hash.each_key do |key|
      if cocktail_hash[key].nil?
        cocktail_hash.delete(key)
      elsif key == 'strDrink'
        Cocktail.create(name: tretm(cocktail_hash[key]))
      elsif key.include? 'strIngredient'
        Ingredient.create(name: tretm(cocktail_hash[key]))
      elsif key.include? 'strMeasure'
        cock = Cocktail.find_by name: tretm(cocktail_hash['strDrink'])
        nam = cocktail_hash["strIngredient#{key[-1]}"]
        nam = '' if nam.nil?
        ingr = Ingredient.find_by name: tretm(nam)
        Dose.create(description: cocktail_hash[key].downcase, cocktail: cock, ingredient: ingr)
      end
    end
  end
end
