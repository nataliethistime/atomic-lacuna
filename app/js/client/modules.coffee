###
# Modules
# This is a stripped down version of the original `smd.js` file that the old web
# client use to setup all the HTTP request methods.
###

'use strict';


module.exports = {
    Alliance:
        url: '/alliance'
        methods: [
            "find"
            "view_profile"
        ]

    Body:
        url: '/body'
        methods: [
            'abandon'
            'get_buildings'
            'get_buildable'
            'get_build_queue'
            'get_status'
            'rename'
        ]

    Buildings: {

        Generic:
            url: '/buildings'
            methods: [
                "build"
                "demolish"
                "downgrade"
                "view"
                "upgrade"
                "repair"
            ]

        Archaeology:
            url: "/archaeology",
            methods: [
                "search_for_glyph"
                "get_glyph_summary"
                "get_glyphs"
                "assemble_glyphs"
                "get_ores_available_for_processing"
                "subsidize_search"
                "view_excavators"
                "abandon_excavator"
            ]

        BlackHoleGenerator: {
            "target": "/blackholegenerator",
            "services": [
                "get_actions_for"
                "generate_singularity"
                "subsidize_cooldown"
            ]
        },

        Capitol: {
            "target": "/capitol",
            "services": {
                "rename_empire"
            }
        },
        Development: {
            "target": "/development",
            "services"
                "cancel_build"
                "subsidize_build_queue"
            }
        },

        DistributionCenter: {
            "target": "/distributioncenter",
            "services": {
                "reserve"
                "release_reserve"
                "get_stored_resources"
            }
        },
        Embassy: {
            "target": "/embassy",
            "services": {
                "create_alliance"
                "dissolve_alliance"
                "get_alliance_status"
                "send_invite"
                "withdraw_invite"
                "accept_invite"
                "reject_invite"
                "get_pending_invites"
                "get_my_invites"
                "assign_alliance_leader"
                "update_alliance"
                "leave_alliance"
                "expel_member"
                "view_stash"
                "donate_to_stash"
                "exchange_with_stash"
            }
        },

        EnergyReserve: {
            "target": "/energyreserve",
            "services": {
                "dump"
                }
            }
        },

        Entertainment: {
            "target": "/entertainment",
            "services": {
                "get_lottery_voting_options"
                "duck_quack"
            }
        },

        Exchanger: {
            "target": "/wasteexchanger",
            "services": {
                "recycle"
                "subsidize_recycling"
            }
        },

        FoodReserve: {
            "target": "/foodreserve",
            "services": {
                "dump"
            }
        },

        GeneticsLab: {
            "target": "/geneticslab",
            "services"
                "run_experiment"
                "rename_species"
            }
        },

        Intelligence: {
            "target": "/intelligence",
            "services": {
                "train_spy"
                "view_spies"
                "burn_spy"
                "assign_spy"
                "name_spy"
                "subsidize_training"
            }
        },

        LibraryOfJith: {
            "target": "/libraryofjith",
            "services": {
                "research_species"
            }
        },

        MercenariesGuild: {
            "target": "/mercenariesguild",
            "services": {
                "add_to_market"
                "get_spies"
                "withdraw_from_market"
                "accept_from_market"
                "view_market"
                "view_my_market"
                "get_trade_ships"
                "report_abuse"
            }
        },

        Mining: {
            "target": "/miningministry",
            "services": {
                "view_platforms"
                "view_ships"
                "add_cargo_ship_to_fleet"
                "remove_cargo_ship_from_fleet"
                "abandon_platform"
            }
        },

        MissionCommand: {
            "target": "/missioncommand",
            "services": {
                "get_missions"
                "complete_mission"
                "skip_mission"
            }
        },

        Network19: {
            "target": "/network19",
            "services": {
                "restrict_coverage"
                "view_news"
            }
        }
    },

    Observatory: {
        "target": "/observatory",
        "services": {
            "abandon_probe"
            "abandon_all_probes"
            "get_probed_stars"
        }
    },


    OreStorage: {
        "target": "/orestorage",
        "services": {
            "dump"
        }
    },

    Park: {
        "target": "/park",
        "services": {
            "throw_a_party"
            "subsidize_party"
        }
    },

    PlanetaryCommand: {
        "target": "/planetarycommand",
        "services": {
            "view_plans"
            "view_incoming_supply_chains"
        }
    },


    Recycler: {
        "target": "/wasterecycling",
        "services": {
            "recycle"
            "subsidize_recycling"
        }
    },

    Security: {
        "target": "/security",
        "services": {
            "view_prisoners"
            "execute_prisoner"
            "release_prisoner"
            "view_foreign_spies"
        }
    },

    Shipyard: {
        "target": "/shipyard",
        "services": {
            "view_build_queue"
            "subsidize_build_queue"
            "subsidize_ship"
            "get_buildable"
            "build_ship"
        }
    },

    SpacePort: {
        "target": "/spaceport",
        "services": {
            "prepare_fetch_spies"
            "fetch_spies"
            "prepare_send_spies"
            "send_spies"
            "get_ships_for"
            "name_ship"
            "recall_ship"
            "recall_all"
            "scuttle_ship"
            "send_fleet"
            "send_ship"
            "view_all_ships"
            "view_foreign_ships"
            "view_ships_travelling"
            "view_ships_orbiting"
            "view_battle_logs"
        }
    },

    SpaceStationLab: {
        "target": "/ssla",
        "services": {
            "make_plan"
            "subsidize_plan"
        }
    },

    SubspaceSupplyDepot: {
        "target": "/subspacesupplydepot",
        "services": {
            "transmit_food"
            "transmit_energy"
            "transmit_ore"
            "transmit_water"
            "complete_build_queue"
        }
    },

    TempleOfTheDrajilites: {
        "target": "/templeofthedrajilites",
        "services": {
            "list_planets"
            "view_planet"
        }
    },

    ThemePark: {
        "target": "/themepark",
        "services": {
            "operate"
        }
    },

    TheDillonForge: {
        "target": "/thedillonforge",
        "services": {
            "make_plan"
            "split_plan"
            "subsidize"
        }
    },

    Trade: {
        "target": "/trade",
        "services": {
            "add_to_market"
            "get_ship_summary"
            "get_ships"
            "get_prisoners"
            "get_plan_summary"
            "get_plans"
            "get_glyph_summary"
            "get_glyphs"
            "withdraw_from_market"
            "accept_from_market"
            "view_market"
            "view_my_market"
            "get_trade_ships"
            "get_waste_ships"
            "get_supply_ships"
            "view_supply_chains"
            "view_waste_chains"
            "create_supply_chain"
            "delete_supply_chain"
            "update_supply_chain"
            "update_waste_chain"
            "add_supply_ship_to_fleet"
            "add_waste_ship_to_fleet"
            "remove_supply_ship_from_fleet"
            "remove_waste_ship_from_fleet"
            "get_stored_resources"
            "push_items"
            "report_abuse"
        }
    },

    Transporter: {
        "target": "/transporter",
        "services": {
            "add_to_market"
            "get_ship_summary"
            "get_ships"
            "get_prisoners"
            "get_plan_summary"
            "get_plans"
            "get_glyph_summary"
            "get_glyphs"
            "withdraw_from_market"
            "accept_from_market"
            "view_market"
            "view_my_market"
            "get_stored_resources"
            "push_items"
            "trade_one_for_one"
            "report_abuse"
        }
    },

    WaterStorage: {
        "target": "/waterstorage",
        "services": {
            "dump"
        }
    },

    Empire: {
        "SMDVersion": "2.0",
        "description": "SMD service demonstration",
        "envelope": "JSON-RPC-2.0",
        "transport": "POST",
        "target": "/empire",
        "services": {
            "is_name_available": {
                "description": "check if empire name is available",
                "parameters": [{
                    "name": "name",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "logout": {
                "description": "logout empire",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "login": {
                "description": "login empire",
                "parameters": [{
                    "name": "name",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "password",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "api_key",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "fetch_captcha": {
                "description": "fetch a captcha for account creation",
                "parameters": [],
                "returns": {
                    "type": "object"
                }
            },
            "create": {
                "description": "create empire",
                "parameters": {
                    name: {
                        "type": "string",
                        "optional": false
                    },
                    password: {
                        "type": "string",
                        "optional": true
                    },
                    password1: {
                        "type": "string",
                        "optional": true
                    },
                    captcha_guid: {
                        "type": "string",
                        "optional": true
                    },
                    captcha_solution: {
                        "type": "string",
                        "optional": true
                    },
                    email: {
                        "type": "string",
                        "optional": true
                    },
                    facebook_uid: {
                        "type": "string",
                        "optional": true
                    },
                    facebook_token: {
                        "type": "string",
                        "optional": true
                    },
                    invite_code: {
                        "type": "string",
                        "optional": true
                    }
                },
                "returns": {
                    "type": "object"
                }
            },
            "found": {
                "description": "found empire",
                "parameters": [{
                    "name": "empire_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "api_key",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "invite_code",
                    "type": "string",
                    "optional": true
                }],
                "returns": {
                    "type": "object"
                }
            },
            "get_status": {
                "description": "get quick empire status",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "view_profile": {
                "description": "Provides a list of the editable properties of the current empire's profile. See also the edit_profile and view_public_profile  methods.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "edit_profile": {
                "description": "Edits properties of an empire. Returns the view_profile method. See also the view_profile and view_public_profile  methods.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "profile",
                    "type": "object",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "view_public_profile": {
                "description": "Provides a list of the data that's publicly known about this empire.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "empire_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "find": {
                "description": "Find an empire by name. Returns a hash reference containing empire ids and empire names.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "name",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "set_status_message": {
                "description": "Sets the empire status message. Similar to what you might put on your Facebook wall, or in a tweet, but about your empire.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "message",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "view_boosts": {
                "description": "Shows the dates at which boosts have expired or will expire. Boosts are subsidies applied to various resources using essentia.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "boost_food": {
                "description": "Spends 5 essentia, and boosts food production on all planets for 7 days. If a boost is already underway, calling again will add 7 more days.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "boost_water": {
                "description": "Spends 5 essentia, and boosts water production on all planets for 7 days. If a boost is already underway, calling again will add 7 more days.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "boost_energy": {
                "description": "Spends 5 essentia, and boosts energy production on all planets for 7 days. If a boost is already underway, calling again will add 7 more days.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "boost_ore": {
                "description": "Spends 5 essentia, and boosts ore production on all planets for 7 days. If a boost is already underway, calling again will add 7 more days.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "boost_happiness": {
                "description": "Spends 5 essentia, and boosts happiness production on all planets for 7 days. If a boost is already underway, calling again will add 7 more days.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "boost_storage": {
                "description": "Spends 5 essentia, and boosts storage (all 5 types) on all planets for 7 days. If a boost is already underway, calling again will add 7 more days.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "boost_building": {
                "description": "Spends 5 essentia, and boosts building queues on all planets for 7 days. If a boost is already underway, calling again will add 7 more days.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "boost_spy_training": {
                "description": "Spends 5 essentia, and boosts spy training on all planets for 7 days. If a boost is already underway, calling again will add 7 more days.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "enable_self_destruct": {
                "description": "Enables a destruction countdown of 24 hours. Sometime after the timer runs out, the empire will vaporize.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "disable_self_destruct": {
                "description": "Disables the self distruction countdown.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "send_password_reset_message": {
                "description": "Starts a password recovery process by sending an email with a recovery key.",
                "parameters": {
                    empire_id: {
                        "type": "string",
                        "optional": true
                    },
                    empire_name: {
                        "type": "string",
                        "optional": true
                    },
                    email: {
                        "type": "string",
                        "optional": true
                    }
                },
                "returns": {
                    "type": "object"
                }
            },
            "reset_password": {
                "description": "Changes the empire password that has been forgotten.",
                "parameters": [{
                    "name": "reset_key",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "password1",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "password2",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "api_key",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "change_password": {
                "description": "Changes the empire password.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "password1",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "password2",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "redeem_essentia_code": {
                "description": "Redeem an essentia code.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "essentia_code",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "update_species": {
                "description": "Updates the empire's species.",
                "parameters": [{
                    "name": "empire_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "params",
                    "type": "object",
                    "optional": false
                }],
                "returns": {
                    "type": "string"
                }
            },
            "redefine_species_limits": {
                "description": "Defines the extra limits placed upon a user that want's to redefine their species.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "redefine_species": {
                "description": "Allows a user to spend essentia and redefine their species affinities, name, and description. This can only be used after the empire has been founded.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "params",
                    "type": "object",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "view_species_stats": {
                "description": "Returns a list of the stats associated with an empire's species as it was originally created.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "get_species_templates": {
                "description": "Returns a list of species templates that can be used to populate the form for update_species.",
                "parameters": [],
                "returns": {
                    "type": "object"
                }
            },
            "invite_friend": {
                "description": "Send an invitation code to a friend so that they can start in the same zone as your empire.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "email",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "message",
                    "type": "string",
                    "optional": true
                }],
                "returns": {
                    "type": "object"
                }
            },
            "get_invite_friend_url": {
                "description": "Returns a URL that can be pasted into a blog, forum, or whatever to invite friends.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            }
        }
    },
    Captcha: {
        "SMDVersion": "2.0",
        "description": "SMD service demonstration",
        "envelope": "JSON-RPC-2.0",
        "transport": "POST",
        "target": "/captcha",
        "services": {
            "fetch": {
                "description": "Retrieves a captcha that is required in order to call the solve method.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "solve": {
                "description": "Validates the user's solution against the known solution for the given guid.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "captcha_guid",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "captcha_solution",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            }
        }
    },
    Inbox: {
        "SMDVersion": "2.0",
        "description": "SMD service demonstration",
        "envelope": "JSON-RPC-2.0",
        "transport": "POST",
        "target": "/inbox",
        "services": {
            "view_inbox": {
                "description": "Displays a list of the messages in the empire's inbox.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "options",
                    "type": "object",
                    "optional": true
                }],
                "returns": {
                    "type": "object"
                }
            },
            "view_archived": {
                "description": "Displays a list of the messages in the empire's archive.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "options",
                    "type": "object",
                    "optional": true
                }],
                "returns": {
                    "type": "object"
                }
            },
            "view_trashed": {
                "description": "Displays a list of the messages in the empire's trash.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "options",
                    "type": "object",
                    "optional": true
                }],
                "returns": {
                    "type": "object"
                }
            },
            "view_sent": {
                "description": "Displays a list of the messages in the empire's outbox.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "options",
                    "type": "object",
                    "optional": true
                }],
                "returns": {
                    "type": "object"
                }
            },
            "read_message": {
                "description": "Retrieves a message. Marks it read if it hasn't been already.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "message_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "archive_messages": {
                "description": "Archives a list of messages.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "message_ids",
                    "type": "array",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "trash_messages": {
                "description": "Trashes a list of messages.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "message_ids",
                    "type": "array",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "send_message": {
                "description": "Sends a message to other players.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "recipients",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "subject",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "body",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "options",
                    "type": "object",
                    "optional": true
                }],
                "returns": {
                    "type": "object"
                }
            }
        }
    },
    Map: {
        "SMDVersion": "2.0",
        "description": "",
        "envelope": "JSON-RPC-2.0",
        "transport": "POST",
        "target": "/map",
        "services": {
            "check_star_for_incoming_probe": {
                "description": "Retrieves a chunk of the map and returns it as an array of hashes.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "star_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "get_star": {
                "description": "Retrieves a single star",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "star_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "get_star_map": {
                "description": "Retrieves a chunk of the star map (lite version).",
                "parameters": [{
                    "name": "args",
                    "type": "object",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "get_stars": {
                "description": "Retrieves a chunk of the map and returns it as an array of hashes.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "x1",
                    "type": "number",
                    "optional": false
                }, {
                    "name": "y1",
                    "type": "number",
                    "optional": false
                }, {
                    "name": "x2",
                    "type": "number",
                    "optional": false
                }, {
                    "name": "y2",
                    "type": "number",
                    "optional": false
                }, {
                    "name": "z",
                    "type": "number",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "get_star_by_name": {
                "description": "Retrieves info on a single star.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "name",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "get_star_by_xy": {
                "description": "Retrieves info on a single star.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "x",
                    "type": "number",
                    "optional": false
                }, {
                    "name": "y",
                    "type": "number",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "search_stars": {
                "description": "If you know a partial name of a star you can search for it. Returns up to 25 results. No body data is returned with this search.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "name",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "number"
                }
            }
        }
    },
    Modules: {
        Parliament: {
            "SMDVersion": "2.0",
            "description": "Parliament",
            "envelope": "JSON-RPC-2.0",
            "transport": "POST",
            "target": "/parliament",
            "services": {
                "view_laws": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "body_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "view_propositions": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "get_stars_in_jurisdiction": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "get_bodies_for_star_in_jurisdiction": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "star_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "get_mining_platforms_for_asteroid_in_jurisdiction": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "asteroid_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "cast_vote": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "proposition_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "vote",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_writ": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "title",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "description",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_repeal_law": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "law_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_transfer_station_ownership": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "to_empire_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_seize_star": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "star_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_rename_star": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "star_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "name",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_broadcast_on_network19": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "message",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_induct_member": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "empire_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "message",
                        "type": "string",
                        "optional": true
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_expel_member": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "empire_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "message",
                        "type": "string",
                        "optional": true
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_elect_new_leader": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "to_empire_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_rename_asteroid": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "asteroid_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "name",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_rename_uninhabited": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "planet_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "name",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_members_only_mining_rights": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_evict_mining_platform": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "platform_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_members_only_excavation": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_evict_excavator": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "platform_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_members_only_colonization": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_neutralize_bhg": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "propose_fire_bfg": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "body_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "reason",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                }
            }
        },
        PoliceStation: {
            "SMDVersion": "2.0",
            "description": "Police Station",
            "envelope": "JSON-RPC-2.0",
            "transport": "POST",
            "target": "/policestation",
            "services": {
                "view_prisoners": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "page_number",
                        "type": "number",
                        "optional": true
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "execute_prisoner": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "prisoner_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "release_prisoner": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "prisoner_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "view_foreign_spies": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "page_number",
                        "type": "number",
                        "optional": true
                    }],
                    "returns": {
                        "type": "object"
                    }
                }
            }
        },
        StationCommand: {
            "SMDVersion": "2.0",
            "description": "Station Command",
            "envelope": "JSON-RPC-2.0",
            "transport": "POST",
            "target": "/stationcommand",
            "services": {
                "view_plans": {
                    "description": "Returns a list of all the plans you've collected through various means.",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                },
                "view_incoming_supply_chains": {
                    "description": "",
                    "parameters": [{
                        "name": "session_id",
                        "type": "string",
                        "optional": false
                    }, {
                        "name": "building_id",
                        "type": "string",
                        "optional": false
                    }],
                    "returns": {
                        "type": "object"
                    }
                }
            }
        }
    },
    Stats: {
        "SMDVersion": "2.0",
        "description": "SMD service demonstration",
        "envelope": "JSON-RPC-2.0",
        "transport": "POST",
        "target": "/stats",
        "services": {
            "credits": {
                "description": "Retrieves a list of the game credits. It is an array of hashes of arrays.",
                "parameters": [],
                "returns": {
                    "type": "array"
                }
            },
            "empire_rank": {
                "description": "Returns a sorted list of empires ranked according to various stats.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "sort_by",
                    "type": "string",
                    "optional": true
                }, {
                    "name": "page_number",
                    "type": "number",
                    "optional": true
                }],
                "returns": {
                    "type": "object"
                }
            },
            "find_empire_rank": {
                "description": "Search for a particular empire in the empire_rank().",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "sort_by",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "empire_name",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            },
            "colony_rank": {
                "description": "Returns a sorted list of planets ranked according to various stats.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "sort_by",
                    "type": "string",
                    "optional": true
                }],
                "returns": {
                    "type": "object"
                }
            },
            "spy_rank": {
                "description": "Returns a sorted list of spies ranked according to various stats.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }, {
                    "name": "sort_by",
                    "type": "string",
                    "optional": true
                }],
                "returns": {
                    "type": "object"
                }
            },
            "weekly_medal_winners": {
                "description": "Returns a list of the empires who won this week's weekly medals.",
                "parameters": [{
                    "name": "session_id",
                    "type": "string",
                    "optional": false
                }],
                "returns": {
                    "type": "object"
                }
            }
        }
    }
};
