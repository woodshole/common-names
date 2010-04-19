var AJAX = (function() {
  var createCommonName = function(name, parent_id){
    $.ajax({
    	type: 'POST',
    	url: "/common_names",
    	data: { id: parent_id, name: name },
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
  
  var getPhotos = function(id){
    $.ajax({
      type: 'GET',
      url: '/photos',
      data: { id: id },
      success: function(response){
        $('#photos').html(response);
        $('#photos > a').lightBox();
        $('#spinner').fadeOut();
      }
    });
  }
  
  var createPhoto = function(id, url){
    $.ajax({
      type: 'POST',
      url: '/photos',
      data: { id: id, url: url }
    });
  }
  
  var getTaxonomyDropdown = function(id, dropdown, language){
    $.ajax({
        type: 'GET',
        url: '/taxonomy/dropdown/' + dropdown, 
        data: { id: id, language: language },
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
