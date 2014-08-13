###
# # Task
# A class that all of the tasks are based off of.
###

# TODO: document these!
requiredAttributes = ['displayName', 'internalName', 'template', 'loadOptions', 'run']

class Task

    validate: ->

        _.each requiredAttributes, (attr) ->
            unless @[attr]?
                throw new Error "#{attr} is required!"
        , @

        yes

    log: (msg = '') ->
        out = $ '#taskRunnerOutputDiv'

        out.append msg
        out.append '<br />'

        msg

    error: (err = '') ->
        out = $ '#taskRunnerOutputDiv'

        out.append '<br />'
        out.append 'Error!!!!'
        out.append '<br />'
        out.append err
        out.append '<br />'
        out.append '<br />'

        throw new Error err



module.exports = Task
