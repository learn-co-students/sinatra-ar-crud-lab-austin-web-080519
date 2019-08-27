
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    @title = params[:title]
    @content = params[:content]
    @article = Article.create(title: @title, content: @content)
    redirect to "/articles/#{@article.id}"
    erb :show
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/:id' do
    id = params[:id]
    @article = Article.find(id)
    erb :show
  end

  get '/articles/:id/edit' do
    id = params[:id]
    @article = Article.find(id)
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    erb :show
  end

  delete '/articles/:id/delete' do
    id = params[:id]
    @article = Article.find(id)
    @article.delete
    redirect to '/articles'
  end

end
