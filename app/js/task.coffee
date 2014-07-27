###
# # Task
# A class that all of the tasks are based off of.
###

class Task

    validate: ->
        unless @displayName?
            throw new Error 'I need a displayName!'

        yes

module.exports = Task
