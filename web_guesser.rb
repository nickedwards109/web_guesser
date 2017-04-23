require 'sinatra'
require 'sinatra/reloader'
require 'pry'

secret_number = rand(101)

get '/' do
  guess = params["guess"]
  message = check_guess(guess, secret_number)
  erb :index, :locals => { :message => message }
end

def check_guess(guess, secret_number)
  if guess_does_not_exist(guess)
     "Please guess a number between 0 and 100."
   elsif guess_is_correct?(guess, secret_number)
     "You guessed correctly! The secret number was #{ secret_number }."
  elsif guess_is_high_but_close(guess, secret_number)
     "You guessed too high, but you are close! Please try again!"
  elsif guess_is_low_but_close(guess, secret_number)
    "You guessed too low, but you are close! Please try again!"
  elsif guess_is_way_too_high(guess, secret_number)
     "You guessed way too high. Please try again."
  elsif guess_is_way_too_low(guess, secret_number)
     "You guessed way too low. Please try again."
  end
end

def guess_does_not_exist(guess)
  guess.nil?
end

def guess_is_correct?(guess, secret_number)
  guess.to_i == secret_number
end

def guess_is_high_but_close(guess, secret_number)
  guess.to_i > secret_number &&  guess.to_i <= secret_number  + 5
end

def guess_is_low_but_close(guess, secret_number)
  guess.to_i < secret_number && guess.to_i >= secret_number - 5
end

def guess_is_way_too_high(guess, secret_number)
  guess.to_i > secret_number + 5
end

def guess_is_way_too_low(guess, secret_number)
  guess.to_i < secret_number - 5
end
