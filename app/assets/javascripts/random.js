//prototype code to strip out after model hooked up

$(document).ready(function() {

  if ($('.random') ) {
    max_letter = 11;
    random = Math.floor(Math.random() * max_letter) + 1


    
    	toggleLetters()
   

    function toggleLetters() {
  	$("#random"+random).show().animate({
        opacity: 1,
      }, 100, function() {});

  	switch(random) {
      case 1:
          $(".randomAvatar").attr("src","/assets/temp_abe.png");
          break;
      case 2:
          $(".randomAvatar").attr("src","/assets/temp_korea.png");
          break;
      case 3:
          $(".randomAvatar").attr("src","/assets/temp_kurt.png");
          break;
      case 4:
          $(".randomAvatar").attr("src","/assets/temp_steinbeck.png");
          break;
      case 5:
          $(".randomAvatar").attr("src","/assets/temp_kurt.png");
          break;
      case 6:
          $(".randomAvatar").attr("src","/assets/temp_vita.png");
          break;
  	case 7:
          $(".randomAvatar").attr("src","/assets/temp_scott.png");
          break;
  	case 8:
          $(".randomAvatar").attr("src","/assets/temp_seneca.png");
          break;
  	case 9:
          $(".randomAvatar").attr("src","/assets/temp_keller.jpg");
          break;
  	case 10:
          $(".randomAvatar").attr("src","/assets/temp_kubrik.png");
          break;
  	case 11:
          $(".randomAvatar").attr("src","/assets/temp_slave.png");
          break;
      default:
          break;
  	}
    }


    $(".roll_dice").click(function(){

    	$("html, body").animate({ scrollTop: 0 }, 100);

    	$(".heart_active").hide();
    	$(".heart").show()

    	$("#random"+random).animate({
        opacity: 0,
      }, 100, function() { $(this).hide(); toggleLetters() });
      random = random + 1;
      if (random > max_letter) {
    	  random = 1
      }
      
     });


    $(".heart").click(function(){
    	$(this).hide();
    	$(".heart_active").show()
     });


    $(".heart_active").click(function(){
    	$(this).hide();
    	$(".heart").show()
     });
  }
 });