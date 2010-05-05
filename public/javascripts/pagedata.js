var pageData = (function() {
  var findCurrentId = function(){
    return $('#family-dropdown').val() || $('#order-dropdown').val() ||
      $('#class-dropdown').val() || $('#phylum-dropdown').val() ||
      $('#kingdom-dropdown').val() || '';
  }
  
  var getTaxonFilter = function(){
    return jQuery.trim($('#taxon-filter-val').text());
  }
  
  var getCommonNamesFilter = function(){
    return jQuery.trim($('#common-filter-val').text());
  }
  
  var getCreationLanguage = function(){
    return $('#language').val();
  }
  
  return {
    findCurrentId: findCurrentId,
    getTaxonFilter: getTaxonFilter,
    getCommonNamesFilter: getCommonNamesFilter,
    getCreationLanguage: getCreationLanguage
  };
})();