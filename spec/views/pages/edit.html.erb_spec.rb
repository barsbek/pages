require 'rails_helper'

RSpec.describe "pages/edit", type: :view do
  before(:each) do
    @page = assign(:page, Page.create!(
      :name => "MyString",
      :title => "MyString",
      :text => "MyText"
    ))
  end

  it "renders the edit page form" do
    render

    assert_select "form[action=?][method=?]", page_path(@page), "post" do

      assert_select "input[name=?]", "page[name]"

      assert_select "input[name=?]", "page[title]"

      assert_select "textarea[name=?]", "page[text]"
    end
  end
end
