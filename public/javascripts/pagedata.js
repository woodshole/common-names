var pageData = (function() {
  var findCurrentId = function(){
    return $('#family-dropdown').val() || $('#order-dropdown').val() ||
      $('#class-dropdown').val() || $('#phylum-dropdown').val() ||
      $('#kingdom-dropdown').val() || '';
  }
  
  var getFilter = function(){
    return jQuery.trim($('#filterval').text());
  }
  
  return {
    findCurrentId: findCurrentId,
    getFilter: getFilter
  };
})();