require 'rails_helper'

RSpec.describe User, type: :model do
  context 'valid attributes' do 
    subject(:user) { create :user }
    it('is valid')          { is_expected.to be_valid }
    it('has name')          { expect(subject.name).to be_present }
    it('has lastname')      { expect(subject.last_name).to be_present }
    it('has email')         { expect(subject.email).to be_present }
    it('has password')      { expect(subject.password).to be_present }
  end

  context 'invalid user' do
    subject(:user) { User.create }
    it('is invalid')          { is_expected.to be_invalid }
    it('has not password')    { expect(subject.errors[:password]).to include "can't be blank"}
  end
end