require 'rails_helper'

RSpec.describe "pages/index", type: :view do
  before(:each) do
    assign(:pages, [
      Page.create!(
        :name => "Name_1",
        :title => "Title",
        :text => "MyText"
      ),
      Page.create!(
        :name => "Name_2",
        :title => "Title",
        :text => "MyText"
      )
    ])
  end

  it "renders a list of pages" do
    render
    assert_select "tr>td", :text => "Name_1".to_s, :count => 1
    assert_select "tr>td", :text => "Name_2".to_s, :count => 1
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
