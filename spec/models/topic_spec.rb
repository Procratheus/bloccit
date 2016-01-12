require 'rails_helper'

describe Topic do

  describe "scopes" do
    include TestFactories

    before do
      @public_topic = Topic.create(name: "Test topic name", description: "Test topic body twenty characters long.")
      @private_topic = Topic.create(name: "Test topic name", description: "Test topic body twenty characters long.", public: false)
    end

    describe "#privately_viewable" do
      it "should return a relation of all privately viewable topics" do
        expect( Topic.privately_viewable ).to eq( [@private_topic] )
      end
    end

    describe "#publicly_viewable" do
      it "should return a relation of all publicly viewable topics" do
        expect( Topic.publicly_viewable ).to eq( [@public_topic] )
      end
    end

    describe "#visible_to(user)" do
      it "should return all topics if a user is present" do
        user = authenticated_user
        expect( Topic.visible_to(user) ).to eq( [@private_topic] )
      end

      it "should return only public topics if a user is nil" do
        user = nil
        expect( Topic.visible_to(user) ).to eq( [@public_topic])
      end
    end
  end

end
