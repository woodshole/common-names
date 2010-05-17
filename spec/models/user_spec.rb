require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  fixtures :users
  
  describe "is_admin?" do
    it "should return true if the user is an admin" do
      User.find(1).is_admin?.should == true
    end
    it "should return false if the user is not an admin" do
      User.find(2).is_admin?.should == false
    end 
  end
end
# # == Schema Information
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

