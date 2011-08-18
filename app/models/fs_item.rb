class FsItem < ActiveRecord::Base
  acts_as_taggable
  acts_as_tree :order => :name

  validates_format_of :name, :with => /\A[^\/]+\z/, :message => 'No forward slash "/" Allowed'
  validates_uniqueness_of :name, :scope => :parent_id

  before_save :update_path

  after_update :update_descendants

  def update_path
    parent_path = self.parent.nil? ? '' : self.parent.path
    self.path = parent_path + '/' + self.name
  end

  def update_descendants
    FsItem.where(:parent_id => self.id).find_each do |item|
      item.save
    end
  end

end

