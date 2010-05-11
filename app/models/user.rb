class User < ActiveRecord::Base
  serialize :options, Hash
  belongs_to :language
  has_and_belongs_to_many :photo
  has_many :common_names
  acts_as_authentic
  
  validates_presence_of :language_id
  
end

# == Schema Information
#
# Table name: users
#
#  id                :integer(4)      not null, primary key
#  email             :string(255)
#  crypted_password  :string(255)
#  password_salt     :string(255)
#  persistence_token :string(255)     not null
#  created_at        :datetime
#  updated_at        :datetime
#  openid_identifier :string(255)
#  language_id       :integer(4)
#

