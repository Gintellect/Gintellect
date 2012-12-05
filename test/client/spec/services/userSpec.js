/*global define, describe, beforeEach, module, it, inject, expect
*/

define(['libs/angularMocks', 'services/userService'], function() {
  'use strict';
  beforeEach(module('ngResource'));
  beforeEach(module('services'));
  beforeEach(function() {
    return this.addMatchers({
      toEqualData: function(expected) {
        return angular.equals(this.actual, expected);
      }
    });
  });
  return describe('users service', function() {
    var $httpBackend, User;
    User = {};
    $httpBackend = {};
    beforeEach(inject(function(_$httpBackend_, $injector) {
      $httpBackend = _$httpBackend_;
      $httpBackend.expectGET('/api/users').respond([
        {
          name: 'Bob'
        }
      ]);
      return User = $injector.get('User');
    }));
    return it('should query users at /api/users and receive an array', function() {
      var result;
      result = User.query();
      $httpBackend.flush();
      return expect(result).toEqualData([
        {
          name: 'Bob'
        }
      ]);
    });
  });
});
