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

  it('should parse properties', function() {
    expect(parser.parse('view id:test title:tester')).toDeepEqual({
      name: 'root',
      properties: {},
      children: [{
        name: 'View',
        properties: {
          id: 'test',
          title: 'tester'
        },
        content: null,
        children: []
      }]
    })
  })

  it('should allow quoted property values', function() {
    expect(parser.parse('view id:test')).toDeepEqual(parser.parse('view id:\'test\''))
  })
})
