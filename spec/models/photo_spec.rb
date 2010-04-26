require 'spec_helper'

describe Photo do
  before(:each) do
    @valid_attributes = {
      :url => "value for url",
      :preferred => false
    }
  end

  it "should create a new instance given valid attributes" do
    Photo.create!(@valid_attributes)
  end
end

# == Schema Information
#
# Table name: photos
#
#  id         :integer(4)      not null, primary key
#  url        :string(255)
#  preferred  :boolean(1)
#  created_at :datetime
#  updated_at :datetime
#  taxon_id   :integer(4)
#

