require 'rails_helper'

describe 'Movie Controller' do
  before(:all) do
    create(:movie, title: 'Star Wars', rating: 'PG', director: 'George Lucas')
    create(:movie, title: 'Blade Runner', rating: 'PG', director: 'Ridley Scott')
    create(:movie, title: 'Alien', rating: 'R', director: '')
    create(:movie, title: 'THX-1138', rating: 'R', director: 'George Lucas')
  end

  describe MoviesController, :type => :controller do
    it 'should be directed to search_director path if match is found' do
      get :search_director, :id => 1
      expect(response).to render_template(:search_director)
    end

    it 'should be redirect to homepage if no match found' do
      get :search_director, :id => 3
      expect(response).to redirect_to(movies_path)
    end

    it 'should be directed to no movies page if movie id does not match' do
      get :search_director, :id => 100
      expect(response).to render_template(:no_movies)
    end

    it 'should be able to create new movie' do
      post :create, :movie => {
        :title => 'New Movie',
        :rating => 'R',
        :director => 'Scott',
        :description => '',
        :release_date => ''
      }
      expect(Movie.where(title: 'New Movie', rating: 'R', director: 'Scott')).not_to be_empty
      expect(response).to redirect_to(movies_path)
    end

    it 'should be able to delete movie' do
      movie = Movie.create!(title: 'to be delete', rating: 'R', director: 'Daniel')
      post :destroy, :id => movie.id
      expect(Movie.where(id: movie.id)).to be_empty
      expect(response).to redirect_to(movies_path)
    end
  end
end
