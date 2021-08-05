require 'rails_helper'

RSpec.describe "Beers", type: :request do
  let(:params)    { {} }
  let(:headers)  {{ "Authorization": "Bearer #{token}" }}

  context '#index' do 
    let(:user)      { create :user }
    let(:token)     { Auth::JsonWebToken.encode(user.to_token) }
    let(:body)      { JSON.parse(response.body) }
    subject { get beers_path, headers: headers, params: params }

    it "fetchs 25 beers" do 
      subject
      expect(body['beers'].length).to eq 25
    end

    it "does not store in DB" do 
      get beers_path, headers: headers, params: params
      expect{ subject }.not_to change { Beer.count }.from(25)
    end

    context "I filter the search with name field" do 
      let!(:beer)   { create :real_beer }
      let!(:params) { { name: beer.name } }

      it "Fetch only one beer" do
        subject
        expect(body['beers'].length).to eq 1
      end
    end
  end

  context "#show" do 
    let(:user)      { create :user }
    let(:token)     { Auth::JsonWebToken.encode(user.to_token) }
    let(:beer)      { create :real_beer}
    let(:body)      { JSON.parse(response.body) }
    subject { get beer_path(1), headers: headers, params: params }
   
    context "Has a stored record in beer table" do 
      let!(:user_beer) {create :user_beer, user: user, beer: beer }

      it "return the just one beer" do 
        subject
        expect(body['beer']).to be_present
        expect(body['beer'].length).to eq 1
      end
    end
  end


  context "#mark_favorite" do 
    let(:user)      { create :user }
    let(:token)     { Auth::JsonWebToken.encode(user.to_token) }
    let(:beer)      { create :real_beer}
    let(:body)      { JSON.parse(response.body) }

    subject { post mark_favorite_path(1), headers: headers, params: params }

    context "Has a stored record in beer table" do 
      let!(:user_beer) {create :user_beer, user: user, beer: beer }

      it "I have not favorite beer" do 
        get my_favorites_path, headers: headers, params: params
        expect(body['favorites_beers'].length).to eq 0
      end

      it "I mark a beer as my favorite" do 
        subject
        expect(body['favorite']).to eq true
      end

      it "I have one favorite beer" do
        subject
        get my_favorites_path, headers: headers, params: params
        expect(body['favorites_beers'].length).to eq 1
      end
    end
  end

end