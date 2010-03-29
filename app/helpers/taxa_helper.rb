module TaxaHelper
  
  def store_current_language_for_js
    if @language
      "var current_language = '" + @language.iso_code + "';"
    else
      'var current_language = "";'
    end
  end
  
end