###
# # Task Runner
# The module that takes care of executing a valid task and displaying the results
# to the user.
###

'use strict'

class TaskRunner

    ###
    # ## TaskRunner.runTask
    # The root of all the operations here. This method does the following to run
    # a task:
    #
    # - Load all of the configuration options the task will need.
    # - Some sort of configuration option validation step?
    # - Open the console output window.
    # - Run the task, putting all output in the window opened before.
    # - When the task finishes. Do a Happy dance! :D :D
    ###

    runTask: (@task, callback) ->
        @task.loadOptions()
        @show()
        @task.run callback


    ###
    # ## TaskRunner.show
    # Show the output dialog.
    ###

    show: ->
        # do stuffs


module.exports = new TaskRunner()
