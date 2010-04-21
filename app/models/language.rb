class Language < ActiveRecord::Base
  has_many :common_names
  has_many :users
  
  validates_presence_of :iso_code, :english_name
  
  def to_s
    english_name
  end
  
  def self.active_languages
    self.find_by_sql("SELECT DISTINCT languages.english_name, languages.id AS lang_id
    FROM common_names 
    JOIN languages 
    ON common_names.language_id = languages.id")  
  end
  
end

# == Schema Information
#
# Table name: languages
#
#  id           :integer(4)      not null, primary key
#  iso_code     :string(255)
#  english_name :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

