       $(function()
        {

         if ($('.draft') ) {

			/*$('#redactor').redactor({
				focus: true,
			    air: true,
			    airButtons: ['formatting', 'bold', 'italic', 'deleted', 'orderedlist', 'link','html'],
			    formattingTags: ['p', 'blockquote', 'pre'],
			    placeholder: true,
			    convertImageLinks: true,
			    convertVideoLinks: true,
			    placeholder: 'Start writing...',

			    changeCallback: function(e)
				{
					var draft_text = this.get()
					if (draft_text.length > 7) {
						$(".send_letter").addClass("send_letter_active")
					} else {
						$(".send_letter").removeClass("send_letter_active")
						setTimeout('$(".save_text").html("");',100);
					}

       				$.ajax({
                      type: "POST",
                      url: "/save_draft",
                      data: {draft: draft_text },
                      success: function(msg){
                          $(".save_text").html("Draft saved");
                      }
                    });
				}
			});
			$('#redactor').redactor('focus');
*/


        

			$("a#mailButton").fancybox({
				'hideOnContentClick': true,
				'autoDimensions'    : false,
		        'width'             : 750,
		        'height'            : 'auto',
		        'transitionIn'      : 'fade',
		        'transitionOut'     : 'fade',
		        'padding' : 0
			});



		    $(".send_to").keydown(function() {
		    	console.log("asdasd")
		     	var client = algoliasearch('XNNH9JSUXG', 'eb5146ae03c021a316d2cb08a06dbdda');
				  var index = client.initIndex('User');

				  index.search($(this).val(), function searchDone(err, content) {
				    console.log(err, content)
				  });
		    });


			  $(".delivery_box").click(function(){
			  	$(".delivery_box").removeClass("box_active")
			  	$(this).addClass("box_active");
			  	var method = $('.delivery_method',$(this)).html();
			  	$("#letter_delivery_method").val(method)
			   });

			  $(".stamp1").click(function(){
            $(".stamp").attr("src","link")
            $(".stamp").css("width","90px")

			   });
			  $(".stamp2").click(function(){
             $(".stamp").attr("src","link")
			   });
			  $(".stamp3").click(function(){
             $(".stamp").attr("src","link")
			   });
				
	 		 $(".privacy_box").click(function(){
			  	$(".privacy_box").removeClass("box_active")
			  	$(this).addClass("box_active");

			  	var privacy = $('.privacy_option',$(this)).html();
			  	if (privacy == "Private") {
			  		$("#letter_private").val(1);
			  		$("#letter_anonymous").val(0);
			  	}
			  	if (privacy == "Public, Redacted") {
			  		$("#letter_private").val(0);
			  		$("#letter_anonymous").val(1);
			  	}
			  	if (privacy == "Public") {
			  		$("#letter_private").val(0);
			  		$("#letter_anonymous").val(0);
			  	}
			   });	

	 		 $(".confirm_send").click(function(){
			  	$(".edit_letter").submit();
			 });	

	 		}

        });





