class Poster < ApplicationRecord

    def self.sort_by_creation(order = all)
        if order == "desc"
            order(created_at: :desc)
        else
            all
        end 
    end

    def self.find_by_params(params)
        all_posters = all
        if params[:name]
           results = filter_by_name(all_posters, params[:name])
        end

        if params[:min_price]
            results = filter_by_min(all_posters, params[:min_price])
        end

        if params[:max_price]
            results = filter_by_max(all_posters, params[:max_price])
        end
        results
    end

    private
    
    def self.filter_by_name(posters, name)
        posters.where("name ILIKE '%#{name}%'").order(:name)
    end

    def self.filter_by_min(posters, min_price)
        posters.where("price >= #{min_price}")
    end

    def self.filter_by_max(posters, max_price)
        posters.where("price <= #{max_price}")
    end
end
