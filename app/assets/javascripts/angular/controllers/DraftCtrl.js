var app = angular.module('slowmail', ['ngRoute','angular-redactor']);

app.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      //when('/showOrders', {
      //  templateUrl: 'templates/show-orders.html',
      // controller: 'ShowOrdersController'
      //}).
      otherwise({
      templateUrl: '/assets/angular/templates/draft.html',
      controller: 'DraftCtrl'
      });
  }]);

app.factory('draftData', ['$http', function($http) {
   return {
        getDraft: function() {
            return $http.get(window.location+'.json')
                .then(function(result) {
                    return result.data;
                });
        }
   }
}]);




app.controller('DraftCtrl', ['$scope', 'draftData', function($scope, draftData) {
    draftData.getDraft().then(function(data) {
    	$scope.data = data
    	$scope.content = data.content
    	$scope.showDraft = true

    	if (window.location.href.replace(/^(?:\/\/|[^\/]+)*\//, "") == "draft") {
    		$scope.reply = true
    	}
    	
    	setTimeout("$('#redactor').redactor('focus');",100);
 
		var saveUpdates = function() {
			var draft_text = $scope.content
			if (draft_text.length > 7) {
				$(".send_letter").addClass("send_letter_active")
			} else {
				$(".send_letter").removeClass("send_letter_active")
				setTimeout('$(".save_text").html("");',100);
			}

       		$.ajax({
                type: "POST",
                url: "/save_draft",
                data: {draft: draft_text, tag: "/"+window.location.href.replace(/^(?:\/\/|[^\/]+)*\//, "") },
                    success: function(msg){
                       $(".save_text").html("Draft saved");
               }
            });

		 }

		 $scope.$watch('content', saveUpdates)

    });
}]);

