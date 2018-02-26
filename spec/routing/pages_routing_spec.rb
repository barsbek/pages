require "rails_helper"

RSpec.describe PagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/").to route_to("pages#index")
    end

    it "routes to #new" do
      expect(:get => "/add").to(
        route_to("pages#new")
      )
      expect(:get => "/name1/add").to(
        route_to("pages#new", path: "name1")
      )
      expect(:get => "/name1/name2/add").to(
        route_to("pages#new", path: "name1/name2")
      )
    end

    it "routes to #show" do
      expect(:get => "/name1").to(
        route_to("pages#show", path: "name1")
      )
      expect(:get => "/name1/name2").to(
        route_to("pages#show", path: "name1/name2")
      )
      expect(:get => "/name1/name2/name3").to(
        route_to("pages#show", path: "name1/name2/name3")
      )
    end

    it "routes to #edit" do
      expect(:get => "/name1/edit").to(
        route_to("pages#edit", path: "name1")
      )
      expect(:get => "/name1/name2/edit").to(
        route_to("pages#edit", path: "name1/name2")
      )
      expect(:get => "/name1/name2/name3/edit").to(
        route_to("pages#edit", path: "name1/name2/name3")
      )
    end

    it "routes to #create" do
      expect(:post => "/name1").to(
        route_to("pages#create", path: "name1")
      )
      expect(:post => "/name1/name2").to(
        route_to("pages#create", path: "name1/name2")
      )
      expect(:post => "/name1/name2/name3").to(
        route_to("pages#create", path: "name1/name2/name3")
      )
    end

    it "routes to #update via PUT" do
      expect(:put => "/name1").to(
        route_to("pages#update", path: "name1")
      )
      expect(:put => "/name1/name2").to(
        route_to("pages#update", path: "name1/name2")
      )
      expect(:put => "/name1/name2/name3").to(
        route_to("pages#update", path: "name1/name2/name3")
      )
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/name1").to(
        route_to("pages#update", path: "name1")
      )
      expect(:patch => "/name1/name2").to(
        route_to("pages#update", path: "name1/name2")
      )
      expect(:patch => "/name1/name2/name3").to(
        route_to("pages#update", path: "name1/name2/name3")
      )
    end

    it "routes to #destroy" do
      expect(:delete => "/name1").to(
        route_to("pages#destroy", path: "name1")
      )
      expect(:delete => "/name1/name2").to(
        route_to("pages#destroy", path: "name1/name2")
      )
      expect(:delete => "/name1/name2/name3").to(
        route_to("pages#destroy", path: "name1/name2/name3")
      )
    end
  end
end
