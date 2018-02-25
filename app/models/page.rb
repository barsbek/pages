class Page < ApplicationRecord
  validates_presence_of :name, :title, :text
  validates :name,
    format: { with: /\A[\wа-я]+\z/i },
    uniqueness: true
end
