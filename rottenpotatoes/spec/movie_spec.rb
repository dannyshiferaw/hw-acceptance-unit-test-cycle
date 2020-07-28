require 'rails_helper'

describe Movie do
  describe 'looking up movies with the same director' do
    before(:all) do
      create(:movie, title: 'Star Wars', rating: 'PG', director: 'George Lucas')
      create(:movie, title: 'Blade Runner', rating: 'PG', director: 'Ridley Scott')
      create(:movie, title: 'Alien', rating: 'R')
      create(:movie, title: 'THX-1138', rating: 'R', director: 'George Lucas')
    end

    it 'given name of a director, returns all movies of that director' do
      george_lucas_movies = Movie.with_director('George Lucas')
      expect(george_lucas_movies.length).to eq(2)
      george_lucas_movies.each do |movie|
        expect(movie).to have_attributes(director: 'George Lucas')
      end
    end

    it 'if name of director not found, returns empty' do
      zero_movies = Movie.with_director('')
      expect(zero_movies).to be_empty
    end
  end
end
