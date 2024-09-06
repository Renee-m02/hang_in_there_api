require 'rails_helper'

RSpec.configure do |config| 
    config.formatter = :documentation 
end

RSpec.describe Poster, type: :model do
  before(:each) do
    @regret = Poster.create!(name: "REGRET",
      description: "Hard work rarely pays off.",
      price: 50.00,
      year: 2018,
      vintage: true,
      img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")

    @sorrow = Poster.create!(name: "Sorrow",
      description: "Hard work rarely pays off.",
      price: 89.00,
      year: 2018,
      vintage: true,
      img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")

    @sadness = Poster.create!(name: "Sadness",
      description: "Hard work rarely pays off.",
      price: 12.00,
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

  describe "Posters find_by_params" do
    it "can find posters that meet the parameters" do
      posters = Poster.find_by_params(name: "r")
      expect(posters.first).to eq(@regret)
      expect(posters.last).to eq(@sorrow)
    end

    it "can show the pricey posters" do
      posters = Poster.find_by_params(min_price: 50.00)
      expect(posters).to eq([@regret, @sorrow])
    end

    it "can filter out overpriced posters" do
      posters = Poster.find_by_params(max_price: 20.00)
      expect(posters).to eq([@sadness])
    end
  end
end
