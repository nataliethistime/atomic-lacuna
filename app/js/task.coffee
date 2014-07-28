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

module.exports = Task
