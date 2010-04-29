var pageData = (function() {
  var findCurrentId = function(){
    return $('#family-dropdown').val() || $('#order-dropdown').val() ||
      $('#class-dropdown').val() || $('#phylum-dropdown').val() ||
      $('#kingdom-dropdown').val() || '';
  }
  
  var getFilter = function(){
    return $('#filterval').text().trim();
  }
  
  return {
    findCurrentId: findCurrentId,
    getFilter: getFilter
  };
})();