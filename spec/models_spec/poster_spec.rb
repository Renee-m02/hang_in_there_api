require 'rails_helper'

RSpec.configure do |config| 
    config.formatter = :documentation 
   end

RSpec.describe Poster, type: :model do
    before(:each) do
      @regret = Poster.create!(name: "REGRET",
        description: "Hard work rarely pays off.",
        price: 89.00,
        year: 2018,
        vintage: true,
        img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")
  
      @failure = Poster.create!(name: "Sorrow",
        description: "Hard work rarely pays off.",
        price: 89.00,
        year: 2018,
        vintage: true,
        img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")
  
      @sadness = Poster.create!(name: "Sadness",
        description: "Hard work rarely pays off.",
        price: 89.00,
        year: 2018,
        vintage: true,
        img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")
    end
  
    describe "Posters sort_by_creation" do
      it "returns posters in ascending order by created_at" do
        posters = Poster.sort_by_creation("asc")
        expect(posters.first).to eq(@regret)
        expect(posters.last).to eq(@sadness)
      end
  
      it "returns posters in descending order by created_at" do
        posters = Poster.sort_by_creation("desc")
        expect(posters.first).to eq(@sadness)
        expect(posters.last).to eq(@regret)
      end
    end
  end