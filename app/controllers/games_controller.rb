require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters_array = ("a".."z").to_a.sample(8)
  end

  def score
    @array = params[:key].split(" ")
    @answer = params['user-answer']
    @array_to_remove = params[:key].split(" ")
    @test_array = true
    @answer.split("").each do |letter|
      if @array_to_remove.include?(letter)
        index = @array_to_remove.find_index(letter)
        index = index.to_i
        @array_to_remove.delete_at(index)
      else
        @test_array = false
      end
    
    end

    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)

    if user['found']
      @test_word = true
    else
      @test_word = false
    end

    if @test_array && @test_word
      @score = @answer.length
      @message = "You won!"
    elsif !@test_array
      @score = 0
      @message = "Your word includes letters outside of the scope"
    else @test_array && !@test_word
      @score = 0
      @message = "Your word is not an english word"
    end
  end
end
