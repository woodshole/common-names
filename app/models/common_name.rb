class CommonName < ActiveRecord::Base
  belongs_to :taxon
  belongs_to :language
end
