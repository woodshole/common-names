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
  
  var getPhotoFilter = function(){
    return jQuery.trim($('#photo-filter-val').text());
  }
  
  var getCreationLanguage = function(){
    return $('#language').val();
  }
  
  var getCreationSource = function(){
    return $("#source").val();
  }
  
  var getCreationName = function(){
    return $('#new-name').val();
  }
  
  var appendToLoc = function(string){
    window.location.href += string + '/'; 
  }
  
  var removeLastLoc = function(){
    var loc = window.location.href.split(/\//);
    loc.pop()
    var toRemove = loc.pop()
    if (toRemove == "#"){
      return false;
    }
    var a = window.location.href;
    window.location.href = a.slice(0,a.lastIndexOf(toRemove));
  }
  
  var getUser = function(){
    return $('#loggedin').length > 0;
  }
  
  return {
    findCurrentId: findCurrentId,
    getTaxonFilter: getTaxonFilter,
    getCommonNamesFilter: getCommonNamesFilter,
    getPhotoFilter: getPhotoFilter,
    getCreationLanguage: getCreationLanguage,
    getCreationSource: getCreationSource,
    getCreationName: getCreationName,
    appendToLoc: appendToLoc,
    removeLastLoc: removeLastLoc,
    getUser: getUser
  };
})();