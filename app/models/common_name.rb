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
    if language
      self.find_by_sql("SELECT common_names.name, common_names.id, common_names.user_id
       FROM common_names 
       JOIN taxa 
       ON common_names.taxon_id = taxa.id 
       WHERE common_names.language_id = #{language.id} 
       AND taxa.id = #{taxa.id} 
       ORDER BY common_names.name ASC")
    else
      self.find_by_sql("SELECT common_names.name, common_names.id, common_names.user_id
      FROM common_names
      JOIN taxa
      ON common_names.taxon_id = taxa.id
      WHERE taxa.id = #{taxa.id}
      ORDER BY common_names.name ASC")
    end
  end
  
  def self.number_translated(language)
    self.find_by_sql("SELECT COUNT(DISTINCT taxon_id) AS ct FROM common_names WHERE language_id = #{language.lang_id}")[0]['ct']
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

