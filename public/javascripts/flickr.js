var Flickr = (function(){
  var api = {
    api_key: 'dbf7edfd64d73e094d2f620158d52ba3',
    base_url: 'http://api.flickr.com/services/rest/',
    methods: {
      search: {
        method: 'flickr.photos.search',
        format: 'json',
        jsoncallback: '?',
        numberOfPics: 8
      }
    }
  }
  
  function flickrSearch(tag){
    var url = api.base_url 
      + '?method=' + api.methods.search.method
      + '&api_key=' + api.api_key
      + '&machine_tags=' + tag
      + '&format=' + api.methods.search.format
      + '&jsoncallback=' + api.methods.search.jsoncallback;
    $.ajax({
      type: 'GET',
      url: url,
      dataType: 'json',
      success: function(rsp){
        if (rsp.stat == 'ok' && rsp.photos.total != 0){
          var defaultPics = (rsp.photos.total < api.methods.search.numberOfPics) ? rsp.photos.total : api.methods.search.numberOfPics;
          // append each photo
          for (var i=0; i<defaultPics; i++) {
            var photo = rsp.photos.photo[i];
            var img = 'http://farm' + photo['farm'] + '.static.flickr.com/' + photo['server'] + '/' + photo['id'] + '_' + photo['secret'] + '_t.jpg';
            $('#photo-' + i).attr('src', img);
          }
        } else {
          $('#photos').append('<div id="no_results">No image results</div>');
        }
      },
      complete: function(){
        $('#spinner').fadeOut('fast'); 
      }
    });
  }
  
  return {
    flickrSearch: flickrSearch
  };
})();