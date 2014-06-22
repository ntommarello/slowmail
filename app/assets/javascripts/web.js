$(document).ready(function() {
  $('.toggleSideMenu').sidr();

     $(window).touchwipe({
        wipeLeft: function() {
          // Close
          $.sidr('close', 'sidr');
        },
        wipeRight: function() {
          // Open
          $.sidr('open', 'sidr');
        },
        preventDefaultEvents: false
      });

     $( "body" ).click(function() {
    	$.sidr('close', 'sidr');
	  });

	$(".diceRow").hover(function(){
    	$('.dice').css('opacity', 1);
    }, function(){
        $('.dice').css('opacity', .6);
    });

  var lastScrollLeft = 0;
  $(window).scroll(function() {
    var documentScrollLeft = $(document).scrollLeft();
    if (lastScrollLeft != documentScrollLeft) {
        console.log('scroll x');
        $.sidr('close', 'sidr');
        lastScrollLeft = documentScrollLeft;
    }
});


});