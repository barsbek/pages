require 'rails_helper'

RSpec.describe "pages/index", type: :view do
  before(:each) do 
    Page.destroy_all
    g = Page.create!(name: :grandpa, title: :t, text: :t)
    p1 = Page.create!(name: :parent, parent: g, title: :t, text: :t)
    p2 = Page.create!(name: :parent_empty, parent: g, title: :t, text: :t)
    ch1 = Page.create!(name: :child1, parent: p1, title: :t, text: :t)
    ch2 = Page.create!(name: :child2, parent: p1, title: :t, text: :t)
  end

  it "renders all pages hierarchy" do
    assign(:pages, Page.roots.map{ |page| page.subtree.arrange })
    render

    assert_select ".pages" do
      # root level
      assert_select ".page" do
        assert_select ".page-title", /grandpa/

        assert_select ".page-subtree" do
          # parent level
          assert_select ".page" do
            assert_select ".page-title", /parent/

            assert_select ".page-subtree" do
              # child level
              assert_select ".page-title", /child1/
              assert_select ".page-title", /child2/
            end
          end

          # parent level
          assert_select ".page" do
            assert_select ".page-title", /parent_empty/
          end
        end
      end
    end
  end
end
