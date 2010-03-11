Transform /^rank \d+$/ do |rank|
  rank.to_i
end

Given /^a taxon of (rank \d+) named "([^\"]*)"$/ do |rank, name|
  @taxon = Taxon.create!({:name => name, :rank => rank})
end

Given /^a common name "([^\"]*)" exists for the taxon named "([^\"]*)"$/ do |common_name, taxon|
  @common_name = CommonName.create!({:name => common_name, :taxon => @taxon})
end

Given /^a taxon of ID 1 exists$/ do
  Taxon.create!({:id => 1, :name => 'UBT', :lft => 1, :rgt => 3399584, :rank => -1})
end

Given /^I am a logged in user$/ do
  User.create!({:password => 'jerome', :password_confirmation => 'jerome', :email => 'agoddard@mbl.edu'})
  steps %Q{
    When I follow "login_button" within "login-buttons"
    And I fill in "email" with "agoddard@mbl.edu"
    And I fill in "password" with "jerome"
    And I press "commit"
  }
end
