{
  // The current indent of the line being parsed
  var indent = 0
  //The string to be consumed and treated as a single indent token
  var indentToken
  //The parent node of the node being parsed
  var parentNode = rootNode = {
    name: 'root',
    properties: {},
    children: [],
    parentNode: null,
    toJSON: function () {
        return {
          name: this.name,
          properties: this.properties,
          content: this.content,
          children: this.children.map(function (node) {
            return rootNode.toJSON.call(node)
          })
        }
    },
  }
  // looks weird
  rootNode.parentNode = rootNode

  function doindent(str, indent) {
    return indent
    .concat(str.split('\n')
    .join('\n' + indent))
  }

  function puts(object) {
    console.log(object)
  }

  function trace(rule, args) {
     console.log('Rule: ' + rule)
     console.log('Arguments: ' + JSON.stringify(args, null, 2))
     console.log('Offset: ' + offset())
     console.log('Line: ' + line())
     console.log('Column: ' + column())
     console.log('');
  }

  function it(iterations, fn) {
    for (i = 0; i < iterations; iterations--) {
      fn(i);
    }
  }

  puts('*** START ***')
}

start
  = SOF

SOF
  = newline*
    nodes:node*
    newline*
    {
      //puts(JSON.stringify(rootNode, null, 2))
      return JSON.stringify(rootNode, null, 2)
    }

node
  = indentChange:indent?
    tag:tag
    {
      trace('node')
      puts('indent by ' + indentChange)
      if (indentChange > 0) {
        it(indentChange, function () {
          // TODO: won't work with multiple indents
          parentNode = parentNode.children[parentNode.children.length - 1]
        })
      } else if (indentChange < 0) {
        it(-indentChange, function () {
          parentNode = parentNode.parentNode
        })
      }

      tag.parentNode = parentNode
      parentNode.children.push(tag)

      return tag
    }

ws 'whitespace'
  = ws:[ ]+
  {
    trace('whitespace', {count: ws.length})
    return ws.join('')
  }

newline 'newline'
  = [\n\r]

tag 'tag'
  = id:id
    properties:(
      ws
      prop:property
      { return prop }
    )*
    content:(
      ws
      content:ROL
      {return content}
    )?
    ws*
    (newline/EOF)
    {
      trace('tag', [id, properties, content])

      ret = {
        name: id,
        properties: {},
        content: content,
        children: [],
      }

      properties.forEach(function(prop) {
        ret.properties[prop.name] = prop.string
      })

      return ret
    }

name 'name'
  = 'id'/
    'title'/
    'layout'/
    'horizontalWrap'

property 'property'
  = name:name colon string:literal
    {
      trace('property', [name, string])
      return {
        name:name,
        string:string
      }
    }

id 'id'
  = view/'Button'/'Label'/tableviewrow

view = 'View'i {return 'View'}
tableviewrow = 'TableViewRow'i {return 'TableViewRow'}

indent
  = space:' '*
  {
    trace('indent', {count: space.length})
    if (!indentToken) {
      indentToken = space.length
    }
    // make sure the indentation is a multiple of the first indentation
    if (space.length % indentToken !== 0) {
      return 0
    }

    var oldIndent = indent
    indent = space.length / indentToken
    var difference = indent - oldIndent

    return difference
  }

colon = ':'
string
  = string:[a-z]i+
  {
    trace('string', string.join(''))
    return string.join('')
  }
quotedString
  = quote string:[^\']* quote
  {
    trace('quotedString', string.join(''))
    return string.join('')
  }
literal = string / quotedString
quote = '\''
EOF = !.
ROL
  = rest:[^\n]+ &(newline/EOF)
  {
    trace('ROL', rest.join('').trimRight())
    return rest.join('').trimRight()
  }
