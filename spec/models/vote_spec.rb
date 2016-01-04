require 'rails_helper'

RSpec.describe Vote, type: :model do

  include TestFactories

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

    describe "#after_save" do
      it "calls Post#update_rank after a new vote is saved on a post" do
        post = associated_post
        vote = Vote.new(post: post, value: 1)
        expect( post ).to receive(:update_rank)
        vote.save
      end
    end
  end


end
