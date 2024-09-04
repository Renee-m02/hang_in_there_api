require 'rails_helper'

describe "Posters" do
  it "shows all posters" do
    Poster.create(name: "Wrecking Ball", length: 220, play_count: 3)
    Poster.create(title: "Bad Romance", length: 295, play_count: 5)
    Poster.create(title: "Shake It Off", length: 219, play_count: 2)

    get '/api/v1/posters'

    expect(response).to be_successful
  end
end