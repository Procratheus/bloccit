require "rails_helper"

describe Vote do

  before do
    @vote = Vote.create!(value: 1)
  end

  describe "Validations" do
    describe "value validations" do
      it "should allow votes to be saved with a value of 1" do
        expect( @vote.value ).to eq(1)
      end

      it "should allow vates to be saved with a value of -1" do
        @vote.update(value: -1)

        expect( @vote.value ).to eq(-1)
      end
    end

  end

end
