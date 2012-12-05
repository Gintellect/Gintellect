/*global define, describe, beforeEach, module, it, inject, expect
*/

define(['libs/angularMocks', 'controllers/usersController'], function(mocks, usersController) {
  'use strict';
  beforeEach(module('ngResource'));
  beforeEach(module('controllers'));
  beforeEach(module('services'));
  beforeEach(function() {
    return this.addMatchers({
      toEqualData: function(expected) {
        return angular.equals(this.actual, expected);
      }
    });
  });
  return describe('users controller', function() {
    var $httpBackend, ctrl, scope;
    scope = {};
    ctrl = {};
    $httpBackend = {};
    beforeEach(inject(function(_$httpBackend_, $rootScope, $controller) {
      $httpBackend = _$httpBackend_;
      $httpBackend.expectGET('/api/users?max=10').respond([
        {
          name: 'Nexus S'
        }, {
          name: 'Motorola DROID'
        }
      ]);
      scope = $rootScope.$new();
      return ctrl = $controller('usersController', {
        $scope: scope
      });
    }));
    return it('should create a users model with 2 users', function() {
      expect(scope.users).toEqual([]);
      $httpBackend.flush();
      return expect(scope.users).toEqualData([
        {
          name: 'Nexus S'
        }, {
          name: 'Motorola DROID'
        }
      ]);
    });
  });
});
