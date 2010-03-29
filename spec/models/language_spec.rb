require 'spec_helper'

describe Language do
  before(:each) do
    @valid_attributes = {
      :iso_code => "value for iso_code",
      :english_name => "value for english_name"
    }
  end

  it "should create a new instance given valid attributes" do
    Language.create!(@valid_attributes)
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

