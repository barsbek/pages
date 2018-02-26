require 'rails_helper'

RSpec.describe Page, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :text }

    describe "#name" do
      let(:valid_names) {
        %w[some_name на_русском with_123 названиe123 123123 some_миксед_23]
      }

      let(:invalid_names) {
        %w[some-text /@#$%^&*() BuRn$ 5M1+h3Rs♡ 2312-2]
      }

      it { is_expected.to validate_presence_of :name }
      it { is_expected.to validate_uniqueness_of :name }

      context "given a valid format" do
        it "passes validation" do
          valid_names.each do |name|
            is_expected.to allow_value(name).for(:name)
          end
        end
      end

      context "given an invalid format" do
        it "doesn't pass validation" do
          invalid_names.each do |name|
            is_expected.not_to allow_value(name).for(:name)
          end
        end
      end
    end
  end

  context "hierarchy" do
    before(:all) do
      Page.destroy_all
      @grand_parent = Page.create!(
        name: "name1",
        title: "grand title",
        text: "grand text"
      )

      @parent = Page.create!(
        name: "name2",
        title: "parent title",
        text: "parent text",
        parent: @grand_parent
      )

      @child = Page.create!(
        name: "name3",
        title: "child title",
        text: "child text",
        parent: @parent
      )
    end

    it "generates correct path" do
      expect(@grand_parent.to_param).to eql("name1")
      expect(@parent.to_param).to eql("name1/name2")
      expect(@child.to_param).to eql("name1/name2/name3")
    end

    describe "#find_by_path" do
      it "finds page if path exists" do
        expect(Page.find_by_path("name1")).to eql(@grand_parent)
        expect(Page.find_by_path("name1/name2")).to eql(@parent)
        expect(Page.find_by_path("name1/name2/name3")).to eql(@child)
      end

      it "raises not_found on non-existing path" do
        expect {
          Page.find_by_path("other_name1")
        }.to raise_error ActiveRecord::RecordNotFound

        expect {
          Page.find_by_path("name1/other_name2")
        }.to raise_error ActiveRecord::RecordNotFound

        expect {
          Page.find_by_path("name1/name2/other_name3")
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    describe "#new_by_path" do
      it "creates new page by path" do
        expect(Page.new_by_path("name1")).to have_attributes(
          @grand_parent.children.new.attributes
        )

        expect(Page.new_by_path("name1/name2")).to have_attributes(
          @parent.children.new.attributes
        )

        expect(Page.new_by_path("name1/name2/name3")).to have_attributes(
          @child.children.new.attributes
        )
      end

      it "raises not_found on non-existing path" do
        expect {
          Page.new_by_path("other_name1")
        }.to raise_error ActiveRecord::RecordNotFound

        expect {
          Page.new_by_path("name1/other_name2")
        }.to raise_error ActiveRecord::RecordNotFound

        expect {
          Page.new_by_path("name1/name2/other_name3")
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
