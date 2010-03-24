class Language < ActiveRecord::Base
  has_many :common_names
  has_many :users
end
