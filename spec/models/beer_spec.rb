require 'rails_helper'

RSpec.describe Beer, type: :model do
  context 'valid attributes' do 
    subject(:beer) { create :simple_beer }
    it('is valid')        { is_expected.to be_valid }
    it('has abv')         { expect(subject.abv).to be_present }
    it('has name')        { expect(subject.name).to be_present }
    it('has tagline')     { expect(subject.tagline).to be_present }
    it('has description') { expect(subject.description).to be_present }
  end
end


