module TaxonomyNavigationHelper
  
  # Returns an array of paired ids and names for the taxonomy navigation
  # dropdowns.
  def options_for_taxonomy_select(taxons=[], selected=nil)
    # Map to sets of names and ids.
    if @language = Language.find_by_iso_code(params[:language])
      elements = taxons.map do |t|
        text = t.common_names.empty? ? "(" + t.name + ")" : t.common_names[0].name
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
