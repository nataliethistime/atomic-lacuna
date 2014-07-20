/*global YAHOO, $, _ */
'use strict';
YAHOO.namespace("lacuna");
var Templates = require('js/templates'),
    assets = require('js/assets');
(function() {
    var Lacuna = YAHOO.lacuna,
        Game = Lacuna.Game;
    var Captcha = function() {
        this.id = "captcha";
        var container = $('<div></div>')
            .attr('id', this.id)
            .addClass('nofooter');
        $(document.body)
            .prepend(container);
        this.dialog = new YAHOO.widget.Panel(this.id, {
            constraintoviewport: true,
            postmethod: "none",
            hideaftersubmit: false,
            fixedcenter: true,
            visible: false,
            draggable: true,
            effect: Game.GetContainerEffect(),
            underlay: false,
            modal: true,
            close: true,
            width: "390px",
            zIndex: 9999
        });
        this.dialog.setHeader('Verify Your Humanity');
        this.dialog.hideEvent.subscribe(function() {
            this.failFunction();
        }, this, true);
        this.dialog.render();
        Game.OverlayManager.register(this.dialog);
    };
    Captcha.prototype = {
        template: Templates.get('menu.captcha'),
        show: function(retry, fail) {
            this.retyFunction = retry;
            this.failFunction = fail;
            this.refreshCaptcha();
            this.render();
            this.dialog.show();
        },
        render: function() {
            this.dialog.setBody(this.template({
                assets: assets
            }));
            $('#captchaRefresh')
                .click(_.bind(this.refreshCaptcha, this));
            $('#solveCaptcha')
                .click(_.bind(this.solveCaptcha, this));
            $('#cancelCaptcha')
                .click(_.bind(this.cancel, this));
        },
        solveCaptcha: function() {
            Lacuna.Pulser.Show();
            Game.Services.Captcha.solve({
                session_id: Game.GetSession(),
                captcha_guid: this.captchaGuid,
                captcha_solution: $('#captchaSolution')
                    .val()
            }, {
                success: function() {
                    Lacuna.Pulser.Hide();
                    this.dialog.hide();
                    this.retyFunction();
                },
                failure: function(o) {
                    this.setError(o.error.message);
                    if (o.error.message === 'Captcha not valid.') {
                        this.refreshCaptcha();
                    }
                    return true;
                },
                scope: this
            });
        },
        refreshCaptcha: function() {
            Lacuna.Pulser.Show();
            this.clear();
            Game.Services.Captcha.fetch({
                session_id: Game.GetSession()
            }, {
                success: function(o) {
                    this.captchaGuid = o.result.guid;
                    $('#captchaImage')
                        .attr('src', o.result.url);
                    Lacuna.Pulser.Hide();
                    this.dialog.show();
                },
                scope: this
            });
        },
        cancel: function() {
            this.dialog.hide();
        },
        clear: function() {
            $('#captchaSolution')
                .text('');
            $('#captchaImage')
                .attr('src', '');
        },
        setError: function(msg) {
            $('#captchaSolution')
                .text('')
                .focus();
            $('#captchaMessage')
                .html(msg)
                .fadeOut(5 * 1000, function() {
                    $(this)
                        .html('&nbsp;');
                });
        }
    };
    Lacuna.Captcha = new Captcha();
}());