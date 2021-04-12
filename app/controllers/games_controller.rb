require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score

    puts "SCORE METHOD"
    p @letters = params[:letters].split('')
    p @answer = params[:answer]
    puts "-------"
    @message = score_and_message(@answer, @letters)
  end

  private

 def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end
  def score_and_message(attempt, grid)
  if included?(attempt.upcase, grid)
    if english_word?(attempt)
      "well done"
    else
      "not an english word"
    end
  else
    "not in the grid"
  end
end
def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
end
end
