require 'rails_helper'

RSpec.describe "pages/show", type: :view do
  before(:each) do 
    Page.destroy_all
    g = Page.create!(name: :grandpa, title: :t, text: :t)
    @p1 = Page.create!(name: :parent, parent: g, title: :t, text: :t)
    p2 = Page.create!(name: :parent_empty, parent: g, title: :t, text: :t)
    ch1 = Page.create!(name: :child1, parent: @p1, title: :t, text: :t)
    ch2 = Page.create!(name: :child2, parent: @p1, title: :t, text: :t)
    
    allow(view).to receive(:current_page?).and_return(false)
    allow(view).to receive(:current_page?).with(@p1).and_return(true)
  end

  it "renders all pages hierarchy" do
    assign(:page, @p1.subtree.arrange)
    render

    # parent level
    assert_select ".page" do |elements|
      assert_select ".page-title", /parent/
      assert_select ".page-links a", "Back"

      assert_select ".page-subtree" do
        # child level
        assert_select ".page" do
          assert_select ".page-title", /child1/
          assert_select ".page-links a", "Show"
        end
        assert_select ".page" do
          assert_select ".page-title", /child2/
          assert_select ".page-links a", "Show"
        end
      end
    end
  end
end
