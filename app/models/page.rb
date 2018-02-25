class Page < ApplicationRecord
  validates_presence_of :name, :title, :text
end
