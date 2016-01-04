require 'rails_helper'

RSpec.describe Vote, type: :model do

  describe "Validations" do
    describe "value validation" do
      before do
        @vote1 = Vote.new(value: 1)
        @vote2 = Vote.new(value: -1)
        @vote3 = Vote.new(value: 2)
      end

      it "should not allow a vote to be saved if it does not equal 1 || -1" do
        expect( @vote1.valid? ).to eq(true)
        expect( @vote2.valid? ).to eq(true)
        expect( @vote3.valid? ).to eq(false)
      end
    end
  end


end
