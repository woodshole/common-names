// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  var page;
  var dds = $("select[id$='-dropdown']");

  // reset everything
  dds.each(function(i){
    $(this).attr('disabled','disabled').val('Any');
  });
  // load kingdom names
  AJAX.getTaxonomyDropdown(1, 'kingdom');
  
  // apply click function to the images
  $("img[id$='_image']").each(function(){
    $(this).click(function(){
      $(this).next().animate({width: 'toggle'});
    });
  });
  
  $("img[id$='_image']").toggle(
    function(){
      $(this).attr("src", '/images/minus_button.gif');
    },
    function(){
      $(this).attr("src", '/images/plus_button.gif');
    }
  );
  
  // taxon options
  $('a.taxon.filter').each(function(){
    $(this).click(function(){
      $('#taxon-filter-val').html($(this).attr('href'));
      $('#taxon_image').trigger('click');
      resetRightOf('kingdom');
      AJAX.getTaxonomyDropdown(1, 'kingdom');
      return false;
    });
  });
  
  // common names options
  $('a.common.filter').each(function(){
    $(this).click(function(){
      $('#common-filter-val').html($(this).attr('href'));
      $('#common_names_image').trigger('click');
      AJAX.getCommonNames(pageData.findCurrentId());
      return false;
    });
  });
  
  $('#create_form').submit(function() {
    AJAX.createCommonName($('#new-name').val(), pageData.findCurrentId());
    return false;
  });

  //delete
  $('a.delete').live('click', function(){
    AJAX.deleteCommonName($(this).attr('dataid'));
    return false;
  });
  
  $('#prev').live('click', function(){
    $('#photos').empty();
    $('#spinner').fadeIn();
    page -= 1;
    AJAX.getPhotos(pageData.findCurrentId(), page);
    return false;
  });
  
  $('#next').live('click', function(){
    $('#photos').empty();
    $('#spinner').fadeIn();
    page += 1;
    AJAX.getPhotos(pageData.findCurrentId(), page);
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

	function updateMainContent(taxon_id){
    $('#create').slideDown();
    $('#names').slideDown();
    $('#best-photo > img').slideDown();
    $('#photos').slideDown();
	  $('#flash').empty();
	  AJAX.getCommonNames(taxon_id);
	  $('#photos').empty();
    AJAX.getPhoto(taxon_id);
    $('#spinner').fadeIn();
      // fade out on the completion of the AJAX event.
    page = 1;
    AJAX.getPhotos(taxon_id, page);
  }

  function resetRightOf(taxa){
    switch(taxa){
      case 'kingdom':
        $('#phylum-dropdown').val('Any').attr('disabled', 'disabled');
        resetRightOf('phylum');
      case 'phylum':
        $('#class-dropdown').val('Any').attr('disabled', 'disabled');
        resetRightOf('class');
      case 'class':
        $('#order-dropdown').val('Any').attr('disabled', 'disabled');
        resetRightOf('order');
      case 'order':
        $('#family-dropdown').val('Any').attr('disabled', 'disabled');
      case 'family':
        return;
      }
  }
  
  function hideMainDivs(){
    $('#create').slideUp();
    $('#names').slideUp();
    $('#best-photo > img').slideUp();
    $('#photos').slideUp();  
  }
  
  //each dropdown except family
  //on change
  //  if change value == '' //ie if Any is selected
  //    reset right of current
  //    disable all to the right of the right
  //    get id to the left
  //    if id still empty //then kingdom is Any
  //      hide everything
  //      return
  //    else
  //      we got something in the one to the left
  //      update content and show
  //  else // we are moving to the right....
  //    get, display, enable next dropdown set
  //    update content and show
  
  // search only once and get all the dropdowns
  
  dds.each(function(index){
    $(this).change(function(){
      var id = $(this).val();
      resetRightOf(jQuery.trim($(this).attr('name')));
      // we got an "Any"
      if (id == '' || id == null) {
        // get the id to the left of the change function
        id = dds.eq(index-1).val();
        // kingdom is "any"
        if (id == '' || id == null) {
          hideMainDivs();
          //return false;
        } else {
          updateMainContent(id);
        }
      } else {
        AJAX.getTaxonomyDropdown(id, dds.eq(index+1).attr('name'));
        updateMainContent(id);
      }
    });
  });
    
  // override submit action and use ajax instead

});