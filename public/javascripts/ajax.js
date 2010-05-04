var AJAX = (function() {
  var createCommonName = function(name, parent_id){
    $.ajax({
    	type: 'POST',
    	url: "/common_names",
    	data: { id: parent_id, name: name},
    	beforeSend: function(req) {
    	  $('#new-name').val('').focus();
    	},
    	success: function(response) {
    	  $('#names').html(response);
    	  $('#new-name').val('');
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
          $('a[href=/common_names/' + id + ']').parent().remove();
        }
      }
    });
  }
  
  var getPhoto = function(id){
    $.ajax({
      type: 'GET',
      url: '/photos/' + id,
      success: function(response){
        $('#best').attr('src', response);
      }
    });
  }
  
  var getPhotos = function(id, page){
    $.ajax({
      type: 'GET',
      url: '/photos',
      data: { id: id, page: page },
      success: function(response){
        $('#photos').html(response);
        $('.thumbs').lightBox();
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
  
  // NOTE THIS IS PARENT ID
  // TODO: send the filter as data as well
  var getTaxonomyDropdown = function(id, dropdown, filter){
    if (dropdown == null) { return; }
    $.ajax({
        type: 'GET',
        url: '/taxa/' + dropdown, 
        data: { id: id, filter: filter },
        success: function(response) {
            $('#' + dropdown + '-dropdown').html(response);
            $('#' + dropdown + '-dropdown').parent().effect('highlight', {}, 2000);
            $('#' + dropdown + '-dropdown').removeAttr('disabled');
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
    getTaxonomyDropdown: getTaxonomyDropdown
  };
})();
