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

  function getCurrentId() {
    return $('#family-dropdown').val() || $('#order-dropdown').val() ||
      $('#class-dropdown').val() || $('#phylum-dropdown').val() || $('#kingdom-dropdown').val() || '';
  }
  
	function updateMainContent(taxon_id, on){
	  $('#flash').empty();
	  AJAX.getCommonNames(taxon_id);
	  $('#photos').empty();
	  if (taxon_id != ''){
      updateFlickr(taxon_id, on);
    }
  }
  
  function updateFlickr(taxon_id, on){
    var taxonName = $('option[value=' + taxon_id + ']').text();
    AJAX.getPhoto(taxon_id);
    var machine_tag = 'taxonomy:' + on + '=' +  taxonName;
    $('#spinner').fadeIn();
    // fade out on the completion of the AJAX event.
    AJAX.getPhotos(machine_tag);
  }

  function resetRightOf(taxa){
    switch(taxa){
      case 'kingdom':
        $('#phylum-dropdown').val('Any');
        resetRightOf('phylum');
      case 'phylum':
        $('#class-dropdown').val('Any');
        resetRightOf('class');
      case 'class':
        $('#order-dropdown').val('Any');
        resetRightOf('order');
      case 'order':
        $('#family-dropdown').val('Any');
      case 'family':
        return;
      }
  }
  
  function disableRightOf(taxa){
    switch(taxa){
      case 'kingdom':
        $('#phylum-dropdown').attr('disabled', 'disabled');
        disableRightOf('phylum');
      case 'phylum':
        $('#class-dropdown').attr('disabled', 'disabled');
        disableRightOf('class');
      case 'class':
        $('#order-dropdown').attr('disabled', 'disabled');
        disableRightOf('order');
      case 'order':
        $('#family-dropdown').attr('disabled', 'disabled');
      case 'family':
        return;
      }
  }
  
  function resetMainDivs(){
    $('#create').slideUp();
    $('#names').slideUp();
    $('#best-photo > img').slideUp();
    $('#photos').slideUp();  
  }
  
  function enableMainDivs(){
    $('#create').slideDown();
    $('#names').slideDown();
    $('#best-photo > img').slideDown();
    $('#photos').slideDown();
  }

  var higherOrder = ['kingdom','phylum','class','order','family'];
  //on load, reset everything to zero
  for (var i=0; i<higherOrder.length; i++){
    $('#' + higherOrder[i] + '-dropdown').attr('disabled','disabled');
    $('#' + higherOrder[i] + '-dropdown').val('Any');
  }
  $('#kingdom-dropdown').attr('disabled','');
  //this just binds the same function to each div
  // #kingdom-dropdown, #phylum-dropdown, etc.
  jQuery.each(higherOrder, function(i, on) {
    $('#' + on + '-dropdown').change(function() {
      right = higherOrder[i+1];
      currentTaxonId = $('#' + on + '-dropdown').val();
      $('#names').fadeOut();  
      resetRightOf(on);
      disableRightOf(right);
      // set something to "any"
      if (currentTaxonId == '') {
        // try to update current_taxon
        currentTaxonId = getCurrentId();
        // if it's still empty, that means kingdom is Any
        if (currentTaxonId == '') {
          resetMainDivs();
        } else {
          // if we got something, update the main content
          updateMainContent(currentTaxonId, higherOrder[i-1]);
        }
        $('#' + right + '-dropdown').attr('disabled', 'disabled');
      } else {
        AJAX.getTaxonomyDropdown(currentTaxonId, right);
        // we have a taxon so we should show the create form
        enableMainDivs();
        updateMainContent(currentTaxonId, on);
      }
    });
    //return after binding the function to order so it doesn't bind to family
    return (on != 'order');
  });

  // defined seperately because it is so simple.
   $('#family-dropdown').change(function() {
     id = $('#family-dropdown').val();
     updateMainContent(id, 'family');
    });
    
  // override submit action and use ajax instead
  $('#create_form').submit(function() {
    AJAX.createCommonName($('#new-name').val(), getCurrentId());
    return false;
  });
  
  // redirect to a language if a language is chosen from the taxonomic browser
  $('#choose_language').change(function(){
    window.location.replace( '/language/' + $(this).val() );
  });

});