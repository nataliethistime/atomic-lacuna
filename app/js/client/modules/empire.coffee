'use strict'

module.exports =
    url: '/empire'
    path: 'empire'
    methods: [
        'is_name_available'
        'logout'
        'login'
        'fetch_captcha'
        'create'
        'found'
        'get_status'
        'view_profile'
        'edit_profile'
        'view_public_profile'
        'find'
        'set_status_message'
        'view_boosts'
        'boost_food'
        'boost_water'
        'boost_energy'
        'boost_ore'
        'boost_happiness'
        'boost_storage'
        'boost_building'
        'boost_spy_training'
        'enable_self_destruct'
        'disable_self_destruct'
        'send_password_reset_message'
        'reset_password'
        'change_password'
        'redeem_essentia_code'
        'update_species'
        'redefine_species_limits'
        'redefine_species'
        'view_species_stats'
        'get_species_templates'
        'invite_friend'
        'get_invite_friend_url'
    ]

    helpers:

        planets: ->

            # Return a list of planets.
            []
