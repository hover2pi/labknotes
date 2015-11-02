// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function(){
  // Tooltips
  $('.tip').tooltip({
    position: 'center right',
    offset: [0, 15],
    effect: 'fade',
    relative: 'true',
    predelay: 300,
    delay: 300,
    tipClass: 'tooltip'
  });

  $('.tooltip').prepend('<span class="arrow"></span>');

  $('.tip-left').tooltip({
    position: 'center left',
    offset: [0, -15],
    effect: 'fade',
    relative: 'true',
    predelay: 300,
    delay: 300,
    tipClass: 'tooltip-left'
  });

  $('.tooltip-left').prepend('<span class="arrow-right"></span>');

  // $('.tip-top').tooltip({
  //   position: 'top center',
  //   offset: [-15, 0],
  //   effect: 'fade',
  //   relative: 'true',
  //   delay: 300,
  //   tipClass: 'tooltip-top'
  // });
  //
  // $('.tooltip-top').prepend('<span class="arrow-bottom"></span>');

  // Strips out empty <p></p>
  $('p:empty').remove();

  // Collapses knote content
  $('div.knote-nav a.collapse').live('click', function(){
      $(this).parents('div.knote').find('div.knote-content').slideToggle();
    return false;
  });

  // Hides formatting by default
  $('div.markup').hide();

  // Shows formatting onclick
  $('a.collapse').live('click', function(){
    $(this).parents('div.formatting').find('div.markup').slideToggle();
    return false;
  });

  // Constrained sliders for reports index
  $('#slider1').slider( {
    value: 25,
    slide: function(ev, ui) {
      return ui.value <= 50;
    }
  } );

  $('#slider1 a').prepend('<span class="line"></span><span class="grade-break center">D | C</span>');

  $('#slider2').slider( {
    value: 50,
    slide: function(ev, ui) {
      var slider1_value = $('#slider1').slider('value');
      return ui.value >= slider1_value;
    }
  } );

  $('#slider2 a').prepend('<span class="line"></span><span class="grade-break center" >C | B</span>');

  $('#slider3').slider( {
    value: 75,
    slide: function(ev, ui) {
      var slider2_value = $('#slider2').slider('value');
      return ui.value >= slider2_value;
    }
  } );

  $('#slider3 a').prepend('<span class="line"></span><span class="grade-break center" >B | A</span>');

  var anim_time = 500,
      easing = "swing";

  // Fix height of each knotes on pageload, resize on scroll
  $('.knotes')
    .addClass('scroller')
    .height(function(i, orig_height) {
      return $('.knotes').eq(i).children('.knote').outerHeight();
    });

  $(".knote .knote-nav .right a").live('click', function(e){
    var $link = $(this),
        $knote = $link.closest('.knote'),
        $container = $knote.closest('.knotes'),
        old_id = $knote.data('id'),
        target_id = "knote_" + $container.data('position') + "_" + $link.data('id');

    if ($link.hasClass("reload")) {
      // Did we do an action that makes this knote stale?
      console.log("Knote reload initiated: " + $link.data('tags'));
    } else {
      slideTo(target_id, "knote_link_" + old_id);
    }
    e.preventDefault();
  });

  var slideTo = function(id, old_id) {
    console.log('scrolling to #' + id + ' from #' + old_id);
    var $target = $('#' + id),
        $link = $('#' + old_id),
        $container = $target.closest('.knotes'),
        new_id = $target.data('id');
    $container.animate({
      marginLeft: -$target.position().left,
      height: $target.outerHeight()
    }, anim_time, easing);
    $link.data('id', new_id)
      .text($target.data('title'))
      .attr({
        href: $link.attr('href').replace(/#.*/, '#' + new_id),
        id: 'knote_link_' + new_id
      });
  };

  var elasticize = function() {

  };

  var data = {},
      methods = {
        init : function(){},
        destroy : function(){}
      };

  $.fn.panedView = function(method) {
    // Method calling logic
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      $.error('Method ' +  method + ' does not exist on jQuery.panedView');
    }
    return true;
  };

});
