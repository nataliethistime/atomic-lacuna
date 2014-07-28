###
# # Task
# A class that all of the tasks are based off of.
###

requiredAttributes = ['displayName', 'internalName', 'template']

class Task

    validate: ->

        _.each requiredAttributes, (attr) ->
            unless @[attr]?
                throw new Error "#{attr} is required!"
        , @

        yes

module.exports = Task
