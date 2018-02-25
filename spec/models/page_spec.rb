require 'rails_helper'

def valid_names
  %w[some_name на_русском with_123 названиe123 123123 some_миксед_23]
end

def invalid_names
  %w[some-text /@#$%^&*() BuRn$ 5M1+h3Rs♡ 2312-2]
end

RSpec.describe Page, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :text }

    describe '#name' do
      context "valid format" do
        valid_names.each do |name|
          it { is_expected.to allow_value(name).for(:name) }
        end
      end

      context "invalid format" do
        invalid_names.each do |name|
          it { is_expected.not_to allow_value(name).for(:name) }
        end
      end
    end
  end
end
