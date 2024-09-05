class Api::V1::PostersController < ApplicationController
    def index
        posters = Poster.all
        options = {}
        options[:meta] = {count: Poster.count}

        if params[:sort] == "desc"
            posters = Poster.order(created_at: :desc)
        else
            posters = Poster.order(:created_at)
        end

        render json: PosterSerializer.new(posters, options)
    end

    def show
        poster = Poster.find(params[:id])
        render json: PosterSerializer.new(poster)
    end

    def create
        new_poster = Poster.create(poster_params)
        render json: PosterSerializer.new(new_poster), status: 201
    end

    def update
        updated_poster = Poster.update(params[:id], poster_params)
        render json: PosterSerializer.new(updated_poster)
    end

    def destroy
        render json: Poster.delete(params[:id]), status: 204
    end
    
    private
    
    def poster_params
        params.require(:poster).permit(:name, :description, :price, :year, :vintage,  :img_url)
    end
end