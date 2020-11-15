class FiguresController < ApplicationController
  # add controller methods

  get '/figures' do 
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if !params[:landmark][:name].empty?
      landmark = Landmark.new(params[:landmark])
      landmark.figure = @figure
      landmark.save
    end
    if !params[:title][:name].empty?
      title = Title.new(params[:title])
      title.figures << @figure
      @figure.save
      title.save
    end
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @titles = Title.all
    @landmarks = Landmark.all
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/edit'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/show'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])
    @figure.save
    if !params[:landmark][:name].empty?
      landmark = Landmark.new(params[:landmark])
      landmark.figure = @figure
      landmark.save
    end
    if !params[:title][:name].empty?
      title = Title.new(params[:title])
      title.figures << @figure
      title.save
    end
    redirect "/figures/#{params[:id]}"
  end
end
