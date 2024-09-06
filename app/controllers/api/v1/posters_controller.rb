class Api::V1::PostersController < ApplicationController
    def index
        posters = if params[:sort]
                    Poster.sort_by_creation(params[:sort])
                  elsif filter_params.present?
                    Poster.find_by_params(filter_params)
                  else
                    Poster.all
                  end
        render json: PosterSerializer.new(posters, meta: { count: posters.count })
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

    def filter_params
        params.permit(:name, :min_price, :max_price)
    end
end