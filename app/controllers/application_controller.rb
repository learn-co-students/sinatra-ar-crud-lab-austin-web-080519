
require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  # CREATE
  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    @new_article = Article.new(params)
    @new_article.save

    redirect "articles/#{@new_article.id}"
  end
  # END

  # READ
  get '/articles' do
    @articles = Article.all

    erb :index
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])

    erb :show
  end
  # END

  # UPDATE
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])

    erb :edit
  end

  patch '/articles/:id' do
    # binding.pry
    @article = Article.find(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    redirect "articles/#{@article.id}"
  end
  # END

  # DELETE
  delete '/articles/:id/delete' do
    binding.pry
    @article = Article.find(params[:id])
    @article.delete
    erb :index
  end


end
