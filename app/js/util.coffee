'use strict'

path = require('path')
cwd = process.cwd()


module.exports.root = ->

    # When in development mode, the cwd is:
    # /home/vasari/atomic-lacuna
    # In a build, it's:
    # /home/vasari/atomic-lacuna/build/linux_binary
    if _.last(cwd.split(path.sep)) is 'atomic-lacuna'
        path.join(process.cwd(), 'app')
    else
        path.join process.cwd(), 'resources', 'app'


module.exports.deepSet = (obj, name, value) ->
    name = name.split('.') if _.isString(name)

    if name.length > 1
        e = name.shift()
        module.exports.deepSet(obj[e] = (if _.isObject(obj[e]) then obj[e] else {}), name, value)
    else
        obj[name[0]] = value

module.exports.deepGet = (obj, name) ->

    # `name` is a '.' separated string indicating where in `obj` it belongs.
    pieces = name.split('.')
    last = null

    # Do some preliminary checking to avoid null errors later on.
    if not obj? or not obj[pieces[0]]
        return null


    _.each pieces, (piece) ->
        last = (last or obj)[piece] or {}

    if last? then last else null

module.exports.year = -> (new Date()).getFullYear()
