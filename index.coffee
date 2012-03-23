_ = require 'underscore'

Pattern = require 'url-pattern'

module.exports = class

    constructor: ->
        @rules = []

    include: (pattern) -> @rules.push {include: true, pattern: new Pattern pattern}
    exclude: (pattern) -> @rules.push {include: false, pattern: new Pattern pattern}

    check: (url) ->
        whitelist = false

        _.each @rules, (rule) -> whitelist = rule.include if rule.pattern.match(url)?

        whitelist
