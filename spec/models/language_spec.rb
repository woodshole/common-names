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
