###
#
# # Script Console
#
# The Script Console is the interface that the player uses to automate their empire's
# repetitive tasks. The general idea is that a user can select a task to run, how
# often and what options to pass in and then the rest is handled. It is comprised of
# the following components:
#
# - A Github repository containing all of the the tasks I approve and have tested
#   to not be malicious and such.
# - A build-persistant data storage of some kind where all the data about tasks and
#   options that the user has setup. This could be a sqlite db or a json file. json
#   *might* work best here.
# - The GUI that pulls all of the above together for the user to use.
# - Finally, some kind of back-end scheduler that runs the tasks at the right time.
#
###

'use strict'

templates = require 'js/templates'
util = require 'js/util'
taskRunner = require 'js/script-console/task-runner'

Lang = YAHOO.lang
Lacuna = YAHOO.lacuna
Game = Lacuna.Game

class ScriptConsole

    ###
    # ## ScriptConsole.constructor
    #
    ###

    constructor: ->

        @id = 'scriptConsole'
        @template = templates.get 'menu.scriptConsole'

        container = $ '<div></div>'
            .attr 'id', @id
            .addClass 'nofooter'

        $ document.body
            .prepend container

        @panel = new YAHOO.widget.Panel @id,
            constraintoviewport: true
            fixedcenter: true
            visible: false
            draggable: true
            effect: Game.GetContainerEffect()
            underlay: false
            close: true
            width: '600px'
            zIndex: 9999

        @panel.setHeader 'Script Console'
        @panel.render()
        Game.OverlayManager.register @panel

        @tasks = @loadTasks()


    ###
    # ## ScriptConsole.loadTasks
    # `require` all of the tasks.
    #
    # Because these tasks can be user generated we need to make sure they're usable.
    # To do this, just call the `validate` method on each one. This method will
    # blow any errors out to the console. Hopefully, this only happens in development. :)
    ###

    loadTasks: ->
        tasks = require 'js/script-console/tasks'

        _.each tasks, (task) ->
            task.validate()

        tasks


    ###
    # ## ScriptConsole.show
    # This is called by the menu when the user clicks on the 'Script Console' item
    # of the top menu bar.
    ###

    show: ->

        @render()
        @open()


    ###
    # ## ScriptConsle.open
    # This method uses `Game`'s `OverlayManager` to hide all other windows that
    # are open. Then it centers and shows the Script Console.
    ###

    open: ->
        Game.OverlayManager.hideAll()
        @panel.show()
        @panel.center()


    ###
    # ## ScriptConsole.render
    # Calls `setBody` on `@panel` to render the template into the `DOM` and sets
    # up all the events.
    ###

    render: (task) =>
        if task?
            @selectedTask = task

            # Provide a few convenience variables for each task's configuration template
            # to use.
            templateOptions =
                planets : Game.getPlanetNames()

            @panel.setBody @template {@tasks, @selectedTask, templateOptions}

        else
            @panel.setBody @template {@tasks}

        @events()


    ###
    # ## ScriptConsole.onChangeTask
    # Method that's called when the user changes the task they're configuring.
    ###

    onChangeTask: (event) =>
        newTaskName = event.target.value
        return unless newTaskName?
        @render @tasks[newTaskName]


    ###
    # ## ScriptConsole.onRunClick
    # Runs the currently selected task. This is done by handling `@selectedTask`
    # over to the `task-runner` module.
    ###

    onRunClick: =>
        taskRunner.runTask @selectedTask, @onTaskFinish


    ###
    # ## ScriptConsole.onTaskFinish
    # Callback that's called when `@selectedTask` has finished executing.
    ###

    onTaskFinish: () =>
        console.log 'Finished Task', @selectedTask


    ###
    # ## ScriptConsole.events
    # Sets up all the events.
    ###

    events: ->
        $ '#' + @id
            .off()
            .on 'change', @onChangeTask

        $ '#runTask'
            .off()
            .on 'click', @onRunClick


module.exports = new ScriptConsole()
