class GamesController < ApplicationController
  LETTERS = ("A".."Z").to_a

  def new
    @letters = []
    10.times do
      @letters << LETTERS.sample
    end
  end

  def score
  end
end
