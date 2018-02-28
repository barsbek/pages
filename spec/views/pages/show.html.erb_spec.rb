require 'rails_helper'

RSpec.describe "pages/show", type: :view do
  before(:each) do 
    Page.destroy_all
    g = Page.create!(name: :grandpa, title: :t, text: :t)
    @p1 = Page.create!(name: :parent, parent: g, title: :t, text: :t)
    p2 = Page.create!(name: :parent_empty, parent: g, title: :t, text: :t)
    ch1 = Page.create!(name: :child1, parent: @p1, title: :t, text: :t)
    ch2 = Page.create!(name: :child2, parent: @p1, title: :t, text: :t)
  end

  it "renders all pages hierarchy" do
    assign(:page, @p1.subtree.arrange)
    render

    # parent level
    assert_select ".page" do
      assert_select ".page-title", /parent/

      assert_select ".page-subtree" do
        # child level
        assert_select ".page-title", /child1/
        assert_select ".page-title", /child2/
      end
    end
  end
end
