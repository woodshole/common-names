class Language < ActiveRecord::Base
  has_many :common_names
  has_many :users
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

