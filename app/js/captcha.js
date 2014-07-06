/*global YAHOO, $, _ */
'use strict';

YAHOO.namespace("lacuna");

var Templates = require('js/templates'),
    assets = require('js/assets');

(function () {
    var Lang = YAHOO.lang,
        Util = YAHOO.util,
        Dom = Util.Dom,
        Event = Util.Event,
        Lacuna = YAHOO.lacuna,
        Game = Lacuna.Game,
        Lib = Lacuna.Library;

    var Captcha = function() {
        this.id = "captcha";

        var container = $('<div></div>').attr('id', this.id).addClass('nofooter');
        $(document.body).prepend(container);

        this.Dialog = new YAHOO.widget.Panel(this.id, {
            constraintoviewport : true,
            postmethod : "none",
            hideaftersubmit : false,
            fixedcenter : true,
            visible : false,
            draggable : true,
            effect : Game.GetContainerEffect(),
            underlay : false,
            modal : true,
            close : true,
            width : "390px",
            zIndex : 9999
        });

        this.Dialog.setHeader('Verify Your Humanity');

        this.Dialog.hideEvent.subscribe(function () {
            this._fail();
        }, this, true);

        this.Dialog.render();
        Game.OverlayManager.register(this.Dialog);
    };

    Captcha.prototype = {
        template : Templates.get('menu.captcha'),

        show : function(retry, fail) {
            this._retry = retry;
            this._fail = fail;
            this.refreshCaptcha();
            this.render();
            this.Dialog.show();
        },

        render : function () {
            this.Dialog.setBody(this.template({assets : assets}));
            $('#captchaRefresh').click(_.bind(this.refreshCaptcha, this));
            $('#solveCaptcha').click(_.bind(this.solveCaptcha, this));
            $('#cancelCaptcha').click(_.bind(this.cancel, this));
        },

        solveCaptcha : function() {
            Lacuna.Pulser.Show();
            Game.Services.Captcha.solve({
                session_id : Game.GetSession(),
                captcha_guid : this._captcha_guid,
                captcha_solution : $('#captchaSolution').val()
            }, {
                success : function(o) {
                    Lacuna.Pulser.Hide();
                    this.Dialog.hide();
                    this._retry();
                },
                failure : function(o) {
                    this.setError(o.error.message);

                    if (o.error.message === 'Captcha not valid.') {
                        this.refreshCaptcha();
                    }

                    return true;
                },
                scope : this
            });
        },

        refreshCaptcha: function() {
            Lacuna.Pulser.Show();
            this.clear();
            Game.Services.Captcha.fetch({
                session_id : Game.GetSession()
            }, {
                success : function (o) {
                    this._captcha_guid = o.result.guid;
                    $('#captchaImage').attr('src', o.result.url);
                    Lacuna.Pulser.Hide();
                    this.Dialog.show();
                },
                scope : this
            });
        },

        cancel : function() {
            this.Dialog.hide();
        },

        clear : function () {
            $('#captchaSolution').text('');
            $('#captchaImage').attr('src', '');
        },

        setError : function(msg) {
            $('#captchaSolution').text('').focus();
            $('#captchaMessage').html(msg).fadeOut(5 * 1000, function () {
                $(this).html('&nbsp;');
            });
        }
    };

    Lacuna.Captcha = new Captcha();
}());
