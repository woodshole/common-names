# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def language_options
    options = Language.all.map!{|d|[d.english_name, d.iso_code]}
    # Add user's language, if it's not the current one.
    options.unshift([current_user.language.to_s, current_user.language.iso_code]) if current_user && current_language != current_user.language
    # Add this option to get back to viewing taxa by all common names.
    options.unshift(['All/Scientific', ''])
    # Add this option, which will be automatically put at the top as the current language. You can't select this language, so it does nothing.
    if current_language.blank?
      options.unshift(['',''])
    else
      options.unshift([current_language.to_s, current_language.iso_code])
    end
    options_for_select(options)
  end
end
