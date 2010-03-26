module TaxonomyNavigationHelper
  
  # Returns an array of paired ids and names for the taxonomy navigation
  # dropdowns.
  def options_for_taxonomy_select(taxons=[], selected=nil)
    
    if @language = Language.find_by_iso_code(params[:language])
      # Map to sets of names and ids.
      elements = taxons.map do |t|
        # Check to see if we're filtering taxa by common names, and skip loop if filter doesn't allow this taxon.
        next if params[:filter] == "common" && t.common_names.empty?
        next if params[:filter] == "latin"  && ! t.common_names.empty?
        
        # If there are no common names, surround the scientific name with parentheses.
        text = t.common_names.empty? ? "(" + t.name + ")" : t.common_names[0].name
        # save this mini array for each elementa
        [text, t.name]
      end
    else
      elements = taxons.map { |t| [t.name, t.name] }
    end
    
    # Prepend the "Any" option.
    elements.unshift(['Any', ''])
    options_for_select elements, selected
  end
  
end
