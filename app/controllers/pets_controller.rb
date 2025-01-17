class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(name: params[:pet][:name])
    #binding.pry
    if !params[:pet][:owner_id]
      @owner = Owner.create(name: params[:pet][:new_owner_name])
    else
      @owner = Owner.find(params[:pet][:owner_id])
    end
    @pet.owner = @owner
    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    #binding.pry
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
    else
      @owner = Owner.find(params[:pet][:owner_id])
    end
    @pet.owner = @owner
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end