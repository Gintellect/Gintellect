angular.module('app').directive 'auth'
, ['$location', '$rootScope'
, ($location, $rootScope) ->
  link = (scope, elem, attrs) ->
    # //once Angular is started, remove class:
    # elem.removeClass('waiting-for-angular');
    
    # var login = elem.find('#login-holder');
    # var main = elem.find('#content');
    
    path = $location.path()
    
    scope.$on 'event:auth-loginRequired', () ->
      path = $location.path()
      $location.path '/login'

    scope.$on 'event:auth-loginConfirmed', () ->
      console.log 'auth login confirmed'
      if path == '/logout'
        path = '/'
      $location.path path
  
  link: link
  restrict: 'C'
]