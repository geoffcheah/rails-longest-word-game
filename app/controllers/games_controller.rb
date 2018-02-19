require 'open-uri'
require 'json'

class GamesController < ApplicationController
  LETTERS = ("A".."Z").to_a

  def new
    @letters = []
    10.times do
      @letters << LETTERS.sample
    end
  end

  def score
    score = 0
    @message = ""
    word = params[:word]
    word_array = word.upcase.split("")
    grid = params[:grid].split(" ")
    if grid_check?(word_array, grid)
      if is_word?(word)
        score = calculate_score(word)
        session[:score] ? session[:score] += score : session[:score] = score
        @message = "Congrats!! You scored #{score} this round. Running score = #{session[:score]}"
      else
        @message = "Not a valid english word"
      end
    else
      @message = "Sorry but #{word.upcase} can't be build out of #{grid}"
    end
  end

  def grid_check?(word_array, grid)
    length = word_array.length
    word_array.all? do |letter|
      grid.include?(letter) && word_array.count(letter) <= grid.count(letter) && length > 1
    end
  end

  def is_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)
    return word["found"]
  end

  def calculate_score(word)
    length = word.length
    return length * 10
  end
end
