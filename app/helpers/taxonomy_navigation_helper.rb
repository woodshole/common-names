module TaxonomyNavigationHelper
  
  # Returns an array of paired ids and names for the taxonomy navigation
  # dropdowns.
  def options_for_taxonomy_select(taxons=[], selected=nil)
    if @language
      # Map to sets of names and ids.
      elements = taxons.map do |t|
        # Check to see if we're filtering taxa by common names, and skip loop if filter doesn't allow this taxon.
        next if session[:filter] == "common" && t.language_common_names(@language).empty?
        next if session[:filter] == "latin"  && ! t.language_common_names(@language).empty?
        
        # If there are no common names, surround the scientific name with parentheses.
        text = t.language_common_names(@language).empty? ? "(" + t.name + ")" : t.language_common_names(@language)[0].name
        # save this mini array for each elementa
        [text, t.id]
      end
    else
      elements = taxons.map { |t| [t.name, t.id] }
    end
    
    # Prepend the "Any" option.
    elements.unshift(['Any', ''])
    options_for_select elements, selected
  end
  
end
