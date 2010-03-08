Given /^that I have created taxon with the attributes:$/ do |table|
  table.hashes.each do |hash|
    Taxon.create!(hash)
  end
end