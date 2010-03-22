// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  
  var config = {
  // public calls only require an API key which is not enough to
  // edit our account.
   api_key:'dbf7edfd64d73e094d2f620158d52ba3',
   link_to_size:'t'
  };
    
    $.fn.centerScreen = function(loaded) {
        var obj = this;
        if(!loaded) {
            obj.css('top', $(window).height()/2-this.height()/2);
            obj.css('left', $(window).width()/2-this.width()/2);
            $(window).resize(function() { obj.centerScreen(!loaded); });
        } else {
            obj.stop();
            obj.animate({ top: $(window).height()/2-this.height()/2, left: $
            (window).width()/2-this.width()/2}, 200, 'linear');
        }
    } 
   
   // Login interface
   $('#login_button').click(function(){
       $('#login-buttons').hide();
       $('#login').show();
   });
   
   $('#login_cancel_button').click(function(){
       $('#login').hide();
       $('#login-buttons').show();
   });
   
   $('.regular_button').click(function(){
      $('#openid').hide();
      $('#standard').show();
   });
   
   $('.openid_button').click(function(){
      $('#standard').hide();
      $('#openid').show();
   });
   
  $('#user_openid_identifier').coolinput({
    blurClass: 'blur',
    iconClass: 'openid_icon'
  });
  
  $('#user_email, #user_password').coolinput({
    blurClass: 'blur'
  });
  
  // KARMA!
  $('#karma-tabs').tabs({
      collapsible: true
  });
  

  
  function get_current_name() {
    return $('#family-dropdown').val() || $('#order-dropdown').val() ||
      $('#class-dropdown').val() || $('#phylum-dropdown').val() || $('#kingdom-dropdown').val();
  }

	function update_main_content(taxon, on){
		$.ajax({
        type: 'GET',
        url: '/taxa/data', 
        data: { taxon_name: taxon },
        beforeSend: function() {
          $('#spinner').fadeIn();
        },
        success: function(response) {
          $('#spinner').fadeOut('fast');
          $('#species').html(response);
          $('#create-new').show();
          $('#species').fadeIn();
        }
    });
    $('#photos').html('');
    var machine_tag = 'taxonomy:' + on + '=' +  taxon;
    $.getJSON('http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=dbf7edfd64d73e094d2f620158d52ba3&machine_tags=' + machine_tag + '&format=json&jsoncallback=?',
    function(rsp) {
       if (rsp.stat != 'ok' || rsp.photos.total == 0){
          $('#photos').append('<div id="no_results">No image results</div>');
          return;
        }
        var pics = (rsp.photos.length < 8) ? rsp.photos.length : 8;
        for (var i=0; i<pics; i++){
          var photo = rsp.photos.photo[i];
          var img = '<img src="http://farm' + photo['farm'] + '.static.flickr.com/' + photo['server'] + '/' + photo['id'] + '_' + photo['secret'] + '_t.jpg" />';
          $('#photos').append(img);
        }
      });
  }
  
  function displayImages(on, taxon, rsp){
        if (rsp.stat != 'ok' || rsp.photos.total == 0){
          $('#photos').append('<div id="no_results">No images for machine tag taxonomy:' + on + '=' +taxon);
          return;
        }
        var pics = (rsp.photos.length < 8) ? rsp.photos.length : 8;
        for (var i=0; i<pics; i++){
          var photo = rsp.photos.photo[i];
          var img = '<img src="http://farm' + photo['farm'] + '.static.flickr.com/' + photo['server'] + '/' + photo['id'] + '_' + photo['secret'] + '_t.jpg" />';
          $('#photos').append(img);
        }
  }
  
  function populate_dropdown(dropdown, taxon){
    $.ajax({
        type: 'GET',
        url: '/taxonomy/dropdown/' + dropdown, 
        data: { parent_name: taxon },
        success: function(response) {
            $('#' + dropdown + '-dropdown').html(response);
            $('#' + dropdown + '-dropdown').parent().effect('highlight', {}, 2000);
            $('#' + dropdown + '-dropdown').removeAttr('disabled');
        }
    });
  }
  
  function reset_right_of(taxa){
    switch(taxa){
      case 'kingdom':
        $('#phylum-dropdown').val('Any');
        reset_right_of('phylum');
      case 'phylum':
        $('#class-dropdown').val('Any');
        reset_right_of('class');
      case 'class':
        $('#order-dropdown').val('Any');
        reset_right_of('order');
      case 'order':
        $('#family-dropdown').val('Any');
      case 'family':
        return;
      }
  }
  
  function disable_right_of(taxa){
    switch(taxa){
      case 'kingdom':
        $('#phylum-dropdown').attr('disabled', 'disabled');
        disable_right_of('phylum');
      case 'phylum':
        $('#class-dropdown').attr('disabled', 'disabled');
        disable_right_of('class');
      case 'class':
        $('#order-dropdown').attr('disabled', 'disabled');
        disable_right_of('order');
      case 'order':
        $('#family-dropdown').attr('disabled', 'disabled');
      case 'family':
        return;
      }
  }

  var higher_order = ['kingdom','phylum','class','order','family'];
  //this just binds the same function to each div
  // #kingdom-dropdown, #phylum-dropdown, etc.
  jQuery.each(higher_order, function(i, on) {
    $('#' + on + '-dropdown').change(function() {
      right = higher_order[i+1];
      current_taxon = $('#' + on + '-dropdown').val();
      $('#species').fadeOut();  
      reset_right_of(on);
      disable_right_of(right);
      if (current_taxon == '') {
        // try to update current_taxon
        current_taxon = (on != 'kingdom') ? $('#' + higher_order[i-1] + '-dropdown').val() : '';
        // if it's still empty, that means kingdom is Any
        if (current_taxon == '') {
          $('#create').slideUp();
          $('#species').fadeOut();
        }
        $('#' + right + '-dropdown').attr('disabled', 'disabled');
      } else {
        populate_dropdown(right, current_taxon);
        // we have a taxon so we should show the create form
        if ($('#create').is(":hidden")) {
          $('#create').slideDown();
        }
      }
      update_main_content(current_taxon, on);
    });
    //return after binding the function to order so it doesn't bind to family
    return (on != 'order');
  });

  // defined seperately because it is so simple.
   $('#family-dropdown').change(function() {
     current_taxon = $('#family-dropdown').val();
     update_main_content(current_taxon, 'family');
    });
    
  // override submit action and use ajax instead
  $('#create_form').submit(function() {
    current_taxon = get_current_name();
    $('#spinner').fadeIn();
  	$.ajax({
  		type: 'POST',
  		url: "/common_names",
  		data: {name: $('#new-name').val(), taxon_name: current_taxon},
  		success: function(response) {
  		  $('#species').html(response);
  		  $('#new-name').val('');
      }
  	});
  	$('#spinner').fadeOut();
    return false;
  });

});
