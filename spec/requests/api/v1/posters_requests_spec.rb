require 'rails_helper'

RSpec.configure do |config| 
 config.formatter = :documentation 
end

RSpec.describe "Poster Request" do 
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

  describe "Fetch All Posters" do
    it "sends a list of posters" do

      get '/api/v1/posters'

      expect(response).to be_successful

      posters = JSON.parse(response.body, symbolize_names: true)[:data]
      
      expect(posters.count).to eq(3)

      posters.each do |poster|
        expect(poster[:type]).to eq("poster")

        expect(poster).to have_key(:id)
        expect(poster[:id]).to be_an(Integer)

        poster = poster[:attributes]

        expect(poster).to have_key(:name)
        expect(poster[:name]).to be_a(String)

        expect(poster).to have_key(:description)
        expect(poster[:description]).to be_a(String)

        expect(poster).to have_key(:price)
        expect(poster[:price]).to be_an(Float)

        expect(poster).to have_key(:year)
        expect(poster[:year]).to be_an(Integer)

        expect(poster).to have_key(:vintage)
        expect(poster[:vintage]).to be_in([true, false])

        expect(poster).to have_key(:img_url)
        expect(poster[:img_url]).to be_an(String)
      end
    end
  end

  describe "Fetch one poster" do
    it "can get one poster by its id" do
      id = Poster.create!(name: "Sadness",
      description: "Hard work rarely pays off.",
      price: 89.00,
      year: 2018,
      vintage: true,
      img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d").id
    
      get "/api/v1/posters/#{id}"
    
      poster1 = JSON.parse(response.body, symbolize_names: true)[:data]
    
      expect(response).to be_successful  

      expect(poster1[:type]).to eq("poster")

      expect(poster1).to have_key(:id)
      expect(poster1[:id]).to be_an(Integer)

      poster1 = poster1[:attributes]

      expect(poster1).to have_key(:name)
      expect(poster1[:name]).to be_a(String)

      expect(poster1).to have_key(:description)
      expect(poster1[:description]).to be_a(String)

      expect(poster1).to have_key(:price)
      expect(poster1[:price]).to be_an(Float)

      expect(poster1).to have_key(:year)
      expect(poster1[:year]).to be_an(Integer)

      expect(poster1).to have_key(:vintage)
      expect(poster1[:vintage]).to be_in([true, false])

      expect(poster1).to have_key(:img_url)
      expect(poster1[:img_url]).to be_an(String)
    end
  end

  describe "Create new poster" do
    it "can create a new poster" do
      poster_params = {
        "name": "DEFEAT",
        "description": "It's too late to start now.",
        "price": 35.00,
        "year": 2023,
        "vintage": false,
        "img_url":  "https://unsplash.com/photos/brown-brick-building-with-red-car-parked-on-the-side-mMV6Y0ExyIk"
      }
      headers = { "CONTENT_TYPE" => "application/json" }
    
      post "/api/v1/posters", headers: headers, params: JSON.generate(poster: poster_params)
      created_poster = Poster.last

      expect(response).to be_successful
      expect(response.code).to eq("201")

      expect(created_poster.name).to eq(poster_params[:name])
      expect(created_poster.description).to eq(poster_params[:description])
      expect(created_poster.price).to eq(poster_params[:price])
      expect(created_poster.year).to eq(poster_params[:year])
      expect(created_poster.vintage).to eq(poster_params[:vintage])
      expect(created_poster.img_url).to eq(poster_params[:img_url])
    end
  end

  describe "Update New Poster" do
    it "can update an existing poster" do
      id = Poster.create!(name: "Sadness",
      description: "Hard work rarely pays off.",
      price: 89.00,
      year: 2018,
      vintage: true,
      img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d").id
      previous_name = Poster.last.name
      poster_params = {name: "Sadness Take 2"}
      headers = {"CONTENT_TYPE" => "application/json"}
    
      patch "/api/v1/posters/#{id}", headers: headers, params: JSON.generate({poster: poster_params})
      updated_poster = Poster.find_by(id: id)

      expect(response).to be_successful

      expect(updated_poster.name).to_not eq(previous_name)
      expect(updated_poster.name).to eq("Sadness Take 2")
    end
  end

  describe "Delete Poster" do
    it "can destroy a poster" do
      poster1 = Poster.create!(name: "Sadness",
      description: "Hard work rarely pays off.",
      price: 89.00,
      year: 2018,
      vintage: true,
      img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")

      # expect(Poster.count).to eq(4)
    
      # delete "/api/v1/posters/#{poster1.id}"

      # expect(response).to be_successful
      # expect(response.code).to eq("204")

      # expect(Poster.count).to eq(3)
      # expect{Poster.find(poster1.id) }.to raise_error(ActiveRecord::RecordNotFound)

      expect{ delete "/api/v1/posters/#{poster1.id}" }.to change(Poster, :count).by(-1)
    
      expect{ Poster.find(poster1.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end