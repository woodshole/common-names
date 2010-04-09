require 'db/seed_methods'
include SeedMethods

def rebuild_lineages
  sql = ActiveRecord::Base.connection();
	sql.begin_db_transaction
	
  Taxon.rebuild_lineages!
  
  sql.commit_db_transaction
end
