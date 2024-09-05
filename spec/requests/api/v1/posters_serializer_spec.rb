require 'rails_helper'

RSpec.configure do |config| 
 config.formatter = :documentation 
end

RSpec.describe "PosterSerializer" do
    before(:each) do
      @regret = Poster.create!(
        name: "REGRET",
        description: "Hard work rarely pays off.",
        price: 89.00,
        year: 2018,
        vintage: true,
        img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
      )
      # Serialize the poster
      @serialized_poster = PosterSerializer.new(@regret).serializable_hash
    end
  
    it "serializes the poster with the correct attributes" do
      # Access the attributes from the serialized poster
      attributes = @serialized_poster[:data][:attributes]
  
      expect(attributes).to include(
        name: "REGRET",
        description: "Hard work rarely pays off.",
        price: 89.00,
        year: 2018,
        vintage: true,
        img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
      )
    end
  end