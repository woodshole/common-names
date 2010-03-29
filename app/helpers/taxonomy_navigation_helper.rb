module TaxonomyNavigationHelper
  
  # Returns an array of paired ids and names for the taxonomy navigation
  # dropdowns.
  def options_for_taxonomy_select(taxons=[], selected=nil)
    if @language
      # Map to sets of names and ids.
      elements = []
      taxons.each do |t|
        # Check to see if we're filtering taxa by common names, and skip loop if filter doesn't allow this taxon.
        next if current_filter == "common" && t.language_common_names(@language).empty?
        next if current_filter == "scientific"  && ! t.language_common_names(@language).empty?
        
        # If there are no common names, surround the scientific name with parentheses.
        if t.language_common_names(@language).empty?
          text = "(" + t.name + ")"
        else
          text = t.language_common_names(@language)[0].name
        end
        # save this mini array for each elementa
        elements << [text, t.name]
      end
    else
      elements = taxons.map { |t| [t.name, t.name] }
    end
    
    # Prepend the "Any" option.
    elements.unshift(['Any', ''])
    options_for_select elements, selected
  end
  
end
