
class CommonNamesController < ApplicationController
  before_filter :require_user, :only => [:create, :report]
  
  def show
    taxon = Taxon.find(params[:id]) || Taxon.root
    @names = taxon.common_names_list(params[:filter], current_language)
    render :partial => "list", :layout => false
  end
  
  def create
    taxon = Taxon.find(params[:id])
    common_name = CommonName.create!(
      :name => params[:name],
      :taxon => taxon,
      :language => Language.find(params[:language]),
      :user => current_user,
      :source => params[:source]
    )
    render :nothing => true, :layout => false
  end
  
  def destroy
    if @common_name = CommonName.find(params[:id])
      @common_name.destroy
      render :json => {:status => "success"}
    else
      render :json => {:status => "failure"}
    end
  end
  
  def report
    file_name = "report_at_#{Time.now}.zip"
    t = Tempfile.new("taxa-#{Time.now}.csv")
    Taxon.find_by_sql("SELECT CONCAT(id, '\t',
                              name,'\t',
                              rank,'\t',
                              parent_id, '\n') as csv 
                       FROM taxa").each do |taxa|
      t.print taxa.csv
    end
    c = Tempfile.new("common-names-#{Time.now}.csv")
    CommonName.find_by_sql("SELECT CONCAT(common_names.taxon_id, '\t',
                              common_names.name, '\t',
                              languages.iso_code, '\n') as csv
                             FROM common_names
                             LEFT JOIN languages
                             ON common_names.language_id = languages.id").each do |cn|
      c.print cn.csv
    end
    p = Tempfile.new("photos-#{Time.now}.csv")
    Photo.find_by_sql("SELECT CONCAT(taxon_id, '\t',
                        preferred, '\t',
                        url, '\n') as csv
                        FROM photos").each do |photo|
      p.print photo.csv
    end
    m = 'db/data/nubHigherTaxa/meta.xml'
   # get meta
    zip = Tempfile.new("report-#{Time.now.to_f}.zip")
    Zip::ZipOutputStream.open(zip.path) do |z|
      z.put_next_entry("taxa.txt")
      z.print IO.read(t.path)
      z.put_next_entry("vernacular.txt")
      z.print IO.read(c.path)
      z.put_next_entry("photos.txt")
      z.print IO.read(p.path)
      z.put_next_entry("meta.xml")
      z.print IO.read(m)
    end
    #send the file
    send_file zip.path, :type => 'application/zip',
                        :disposition => 'attachment',
                        :filename => file_name
    t.close!
    c.close!
    p.close!
    # m.close
    zip.close
    #zip
  end
  
end