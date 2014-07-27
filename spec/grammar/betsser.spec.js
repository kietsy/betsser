'use strict';
var parser = require('../../grammar/betsser')
  // var fs = require('fs')
  // var parser = require('pegjs').buildParser(fs.readFileSync('grammar/betsser.pegjs', 'utf8'));

describe('Parser', function() {
  it('should be case insensetive', function() {
    expect(parser.parse('TableViewRow')).toDeepEqual(parser.parse('tAbLeViEwRoW'))
  })

  it('should allow trailing new line characters', function() {
    expect(parser.parse('view\n\n\n')).toDeepEqual(parser.parse('view'))
  })
})
