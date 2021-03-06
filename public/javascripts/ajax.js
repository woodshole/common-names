var AJAX = (function() {
  var createCommonName = function(parent_id){
    $.ajax({
    	type: 'POST',
    	url: "/common_names",
    	data: { id: parent_id,
    	  name: pageData.getCreationName(),
    	  language: pageData.getCreationLanguage(),
    	  source: pageData.getCreationSource()
    	},
    	beforeSend: function(req) {
    	  $('#new-name').val('').focus();
    	},
    	success: function(response) {
    	  getCommonNames(parent_id);
  	  },
      error: function(){
        alert(name + " already exists");
      }
    });
  }
  
  var getCommonNames = function(id){
    $.ajax({
        type: 'GET',
        url: '/common_names/' + id,
        data: {filter: pageData.getCommonNamesFilter()},
        success: function(response) {
          $('#names').html(response);
          $('#create-new').show();
          $('#names').fadeIn();
        }
    });
  }
  
  var deleteCommonName = function(id){
    $.ajax({
      type: 'DELETE',
      url: '/common_names/' + id,
      dataType: 'json',
      success: function(response){
        if (response.status == "success"){
          $('a[href=/common_names/' + id + ']').parent().parent().remove();
        }
      }
    });
  }
  
  var getPhoto = function(id){
    $.ajax({
      type: 'GET',
      url: '/photos/' + id,
      befreSend: function(){
        $('#best-photo').empty();
      },
      success: function(response){
        $('#best-photo').html('<img src="' + response + '" id="best"/>');
      }
    });
  }
  
  var getPhotos = function(id, page){
    $('#photos').empty();
    if (pageData.getPhotoFilter() == 'Off'){
      return false;
    }
    $('#spinner').fadeIn();
    $.ajax({
      type: 'GET',
      url: '/photos',
      data: { id: id, page: page },
      success: function(response){
        $('#photos').html(response);
        $('.thumbs').lightBox();
        $('#spinner').fadeOut();
      },
      error: function(rsp){
        $('#photos').html("<p>There was an error</p>");
        $('#spinner').fadeOut();
      }
    });
  }
  
  var createPhoto = function(id, url){
    $.ajax({
      type: 'POST',
      url: '/photos',
      data: { id: id, url: url },
      success: function(response){
        $('#best').attr('src', response);
      }
    });
    
  }

  var getTaxonomyDropdown = function(id, dropdown){
    if (dropdown == null) { return; }
    $.ajax({
        type: 'GET',
        url: '/taxa/' + dropdown, 
        data: { id: id, filter: pageData.getTaxonFilter() },
        success: function(response) {
            $('#' + dropdown + '-dropdown').html(response);
            $('#' + dropdown + '-dropdown').parent().effect('highlight', {}, 2000);
            $('#' + dropdown + '-dropdown').removeAttr('disabled');
        }
    });
  }
  
  var getStats = function(){
    $.ajax({
      type: 'GET',
      url: '/stats/' + pageData.findCurrentId(),
      beforeSend: function(){
        $('#stats-table tr:gt(0)').empty();
      },
      success: function(response){
        $('#stats-table tr:last').after(response);
      }
    });
  }


  return {
    createCommonName: createCommonName,
    getCommonNames: getCommonNames,
    deleteCommonName: deleteCommonName,
    getPhoto: getPhoto,
    getPhotos: getPhotos,
    createPhoto: createPhoto,
    getTaxonomyDropdown: getTaxonomyDropdown,
    getStats: getStats
  };
})();
