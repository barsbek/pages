require 'rails_helper'

RSpec.describe "pages/new", type: :view do
  before(:each) do
    assign(:page, Page.new(
      :name => "MyString",
      :title => "MyString",
      :text => "MyText"
    ))
  end

  it "renders new page form" do
    render

    assert_select "form[action=?][method=?]", pages_path, "post" do

      assert_select "input[name=?]", "page[name]"

      assert_select "input[name=?]", "page[title]"

      assert_select "textarea[name=?]", "page[text]"
    end
  end
end
