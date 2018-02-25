class Page < ApplicationRecord
  has_ancestry

  validates_presence_of :name, :title, :text
  validates :name,
    format: { with: /\A[\wа-я]+\z/i },
    uniqueness: true
  
  def to_param
    @to_param ||= Page.where(id: path_ids)
      .order(:created_at)
      .pluck(:name)
      .join('/')
  end

  def self.find_by_path(path)
    names = path.to_s.split('/')
    ids = Page.where(name: names).pluck(:id)
    page = Page.find_by(name: names.last)
    if page.present? && page.path_ids.to_set == ids.to_set
      page
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def self.new_by_path(path)
    parent = Page.find_by_path(path)
    if parent.present? && path.present?
      @page = parent.children.new
    else
      @page = Page.new
    end
  end
end
