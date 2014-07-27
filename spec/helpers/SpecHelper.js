'use strict';

beforeEach(function () {
  jasmine.addMatchers({
    toDeepEqual: function() {
      return {
        compare: function(actual, expected) {
          return {
            pass: JSON.stringify(actual) === JSON.stringify(expected)
          }
        }
      }
    }
  });
});
