class Poster < ApplicationRecord
    def self.sort_by_creation(order = all)
        if order == 'desc'
          order(created_at: :desc)
        # elsif order == 'desc'
        #   order(created_at: :desc)
        else
          all
        end
    end

    # def self.total_count
    #     count
    # end
end