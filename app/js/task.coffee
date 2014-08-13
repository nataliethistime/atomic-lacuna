###
# # Task
# A class that all of the tasks are based off of.
###

# This is the list of all the attributes a Task needs to contain.
# To see an example of all these, have a look at the Push Glyphs task.
requiredAttributes = [

    # - `displayName`, the name that the user sees when they select this task.
    'displayName'

    # - `internalName`, the name is used to identify this task within the HTML.
    'internalName'

    # - `template`, the Handlebars template that will render all of the controls
    #   required to configure this task.
    'template'

    # - `loadOptions`, a function that will be called before the task is run. It
    #   should return a human readable error string if anything is wrong. Otherwise
    #   it should return `true`.
    'loadOptions'

    # - `run`, the function that will be called when the user has clicked the run
    #   button and everything is in order to go. Put your task's logic in here.
    'run'
]

class Task


    ###
    # ## Task.validate
    # Checks to make sure this task is valid according to the needed attributes
    # specified above.
    ###

    validate: ->

        _.each requiredAttributes, (attr) ->
            unless @[attr]?
                throw new Error "#{attr} is required!"
        , @

        yes


    ###
    # ## Task.log
    # This functions prints the given message to the output console.
    ###

    log: (msg = '') ->
        out = $ '#taskRunnerOutputDiv'
        out.append "#{msg}<br />"
        msg


    ###
    # ## Task.error
    # This function displays an error in the output console and throws a new `Error`.
    ###

    error: (err = '') ->
        out = $ '#taskRunnerOutputDiv'
        out.append "<br /><span style=\"color: red;\">Error: #{err}</span><br />"
        throw new Error err



module.exports = Task
