require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  let(:valid_attributes) {
    { name: 'name1', title: 'title1', text: 'some_text' }
  }

  let(:invalid_attributes) {
    { name: 'name-1/!@#$%^&*()', title: '', text: '' }
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      page = Page.create! valid_attributes
      get :show, params: {path: page.to_param}
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      page = Page.create! valid_attributes
      get :edit, params: {path: page.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Page" do
        expect {
          post :create, params: {page: valid_attributes}
        }.to change(Page, :count).by(1)
      end

      it "redirects to the created page" do
        post :create, params: {page: valid_attributes}
        expect(response).to redirect_to(Page.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {page: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: 'another_name', title: "some new title", text: 'new text' }
      }

      it "updates the requested page" do
        page = Page.create! valid_attributes
        put :update, params: {path: page.to_param, page: new_attributes}
        page.reload
        expect(response).to redirect_to(Page.find(page.id))
      end

      it "redirects to the page" do
        page = Page.create! valid_attributes
        put :update, params: {path: page.to_param, page: valid_attributes}
        expect(response).to redirect_to(page)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        page = Page.create! valid_attributes
        put :update, params: {path: page.to_param, page: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested page" do
      page = Page.create! valid_attributes
      expect {
        delete :destroy, params: {path: page.to_param}
      }.to change(Page, :count).by(-1)
    end

    it "redirects to the pages list" do
      page = Page.create! valid_attributes
      delete :destroy, params: {path: page.to_param}
      expect(response).to redirect_to(pages_url)
    end
  end

end
