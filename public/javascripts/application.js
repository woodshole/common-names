// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  var state = 'up';
  $('#options_image').click(function(){
    if (state == 'up') {
      $('#options_image').attr("src", '/images/minus_button.gif');
      $('#options').slideDown();
      state = "down";
    } else { 
      $('#options_image').attr("src", '/images/plus_button.gif');
      $('#options').slideUp();
      state = "up";
    }
  });
  
  $('a.delete').live('click', function(){
    AJAX.deleteCommonName($(this).attr('dataid'));
    return false;
  });
  
  $('#user').click(function(){
      this.focus();
      this.select();
  });
  
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

  function get_current_id() {
    return $('#family-dropdown').val() || $('#order-dropdown').val() ||
      $('#class-dropdown').val() || $('#phylum-dropdown').val() || $('#kingdom-dropdown').val();
      return false;
  }
  
  //exemplary photo
  $('.exemplary').each(function(){
    $(this).click(function(){
      var url = $(this).find('img').attr('src');
      AJAX.createPhoto(get_current_id(), url.replace('_t.jpg', '.jpg'));
      $('#best').attr('src', url.replace('_t.jpg','_m.jpg'));
      return false;
    });  
  });
  
	function update_main_content(taxon_id, on){
	  $('#flash').empty();
	  AJAX.getCommonName(taxon_id)
    update_flickr(taxon_id, on);
  }
  
  function update_flickr(taxon_id, on){
    empty_flickr_imgs();
    var taxon_name = $('option[value=' + taxon_id + ']').text();
    if (taxon_id == ''){
      return;
    }
    AJAX.getPhoto(taxon_id);
    var machine_tag = 'taxonomy:' + on + '=' +  taxon_name;
    $('#spinner').fadeIn();
    // fade out on the completion of the AJAX event.
    Flickr.flickrSearch(machine_tag)
  }
  
  function empty_flickr_imgs(){
    $('#no_results').remove();
    for (var i=0; i<8; i++){
      $('#photo-' + i).attr('src','');
    }
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
  //on load, reset everything to zero
  for (var i=0; i<higher_order.length; i++){
    $('#' + higher_order[i] + '-dropdown').attr('disabled','disabled');
    $('#' + higher_order[i] + '-dropdown').val('Any');
  }
  $('#kingdom-dropdown').attr('disabled','');
  //this just binds the same function to each div
  // #kingdom-dropdown, #phylum-dropdown, etc.
  jQuery.each(higher_order, function(i, on) {
    $('#' + on + '-dropdown').change(function() {
      right = higher_order[i+1];
      current_taxon_id = $('#' + on + '-dropdown').val();
      $('#names').fadeOut();  
      reset_right_of(on);
      disable_right_of(right);
      if (current_taxon_id == '') {
        // try to update current_taxon
        current_taxon_id = (on != 'kingdom') ? $('#' + higher_order[i-1] + '-dropdown').val() : '';
        // if it's still empty, that means kingdom is Any
        if (current_taxon_id == '') {
          $('#create').slideUp();
          $('#names').fadeOut();
        }
        $('#' + right + '-dropdown').attr('disabled', 'disabled');
      } else {
        AJAX.getTaxonomyDropdown(current_taxon_id, right);
        // we have a taxon so we should show the create form
        if ($('#create').is(":hidden")) {
          $('#create').slideDown();
        }
      }
      update_main_content(current_taxon_id, on);
    });
    //return after binding the function to order so it doesn't bind to family
    return (on != 'order');
  });

  // defined seperately because it is so simple.
   $('#family-dropdown').change(function() {
     id = $('#family-dropdown').val();
     update_main_content(id, 'family');
    });
    
  // override submit action and use ajax instead
  $('#create_form').submit(function() {
    AJAX.createCommonName($('#new-name').val(), get_current_id());
    return false;
  });
  
  // redirect to a language if a language is chosen from the taxonomic browser
  $('#choose_language').change(function(){
    window.location.replace( '/language/' + $(this).val() );
  });

});