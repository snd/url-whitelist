newPattern = require 'url-pattern'

whitelist =
    include: (pattern) -> @rules.push {include: true, pattern: newPattern pattern}
    exclude: (pattern) -> @rules.push {include: false, pattern: newPattern pattern}

    check: (url) ->
        allow = false
        @rules.forEach (rule) -> allow = rule.include if rule.pattern.match(url)?
        allow

module.exports = ->
    w = Object.create whitelist
    w.rules = []
    w
