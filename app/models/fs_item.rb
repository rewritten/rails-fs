class FsItem < ActiveRecord::Base
  acts_as_taggable
  acts_as_tree :order => :name

  validates :name,
             :format => { :with => /\A[^\/]+\Z/ } ,
             :uniqueness => { :scope => :parent_id, :case_sensitive => false }
  validates :parent, :is_a => { :class => :directory }, :allow_nil => true

  before_save :update_path

  after_update :update_descendants

  def update_path
    parent_path = self.parent.nil? ? '' : self.parent.path
    self.path = parent_path + '/' + self.name
  end

  def update_descendants
    # TODO: use an actual SQL update instead of recursion.
    FsItem.where(:parent_id => self.id).find_each do |item|
      item.save
    end
  end

end

