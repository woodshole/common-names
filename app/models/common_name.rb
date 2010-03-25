class CommonName < ActiveRecord::Base
  belongs_to :taxon
  belongs_to :language
end

# == Schema Information
#
# Table name: common_names
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  taxon_id    :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#  language_id :integer(4)
#

