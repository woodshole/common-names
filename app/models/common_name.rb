class CommonName < ActiveRecord::Base
  belongs_to :taxon
  belongs_to :language
  belongs_to :user
  
  validates_presence_of :name, :taxon_id, :language_id
  validates_uniqueness_of :name, :scope => [:user_id, :taxon_id]
  
  def owned_by?(user)
    return false if user == nil
    return self.user == user
  end
  
  def self.language_filter(taxa=nil, language=nil)
    sql = "SELECT common_names.name, 
      common_names.id, 
      common_names.user_id
     FROM common_names 
     JOIN taxa 
     ON common_names.taxon_id = taxa.id"
    sql += " WHERE common_names.language_id = #{language.id}" unless language.nil?
    sql += " AND taxa.id = #{taxa.id}
     ORDER BY common_names.name ASC"
    self.find_by_sql(sql)
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
#  user_id     :integer(4)
#

