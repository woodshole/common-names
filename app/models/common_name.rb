class CommonName < ActiveRecord::Base
  belongs_to :taxon
  belongs_to :language
  belongs_to :user
  
  validates_presence_of :name, :taxon_id, :language_id
  validates_uniqueness_of :name, :scope => [:taxon_id]
  
  def owned_by?(user)
    return self.user == user
  end
end

# == Schema Information
#
# Table name: common_names
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  taxon_id    :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#  language_id :integer(4)
#

