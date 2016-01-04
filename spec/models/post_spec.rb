require "rails_helper"

describe Post do

  include TestFactories

  describe "vote_methods" do

    before do
      @post = associated_post
      3.times { @post.votes.create(value: 1) }
      2.times { @post.votes.create(value: -1) }
    end

    describe "#up_votes" do
      it "should count the number of votes with a value of -1" do
        expect( @post.up_votes ).to eq(3)
      end
    end

    describe "#down_votes" do
      it "should count the number of votes with a value of 1" do
        expect( @post.down_votes ).to eq(2)
      end
    end

    describe "#points" do
      it "should count the sum of all up and down votes " do
        expect( @post.points ).to eq(1)
      end
    end

    describe "#create_vote" do
      it "should create and up vote when a vote is saved" do
        post = associated_post
        expect( post.up_votes ).to eq(0)
        post.create_vote
        expect( post.up_votes ).to eq(1)
      end
    end

  end

end
