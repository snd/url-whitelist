Whitelist = require './index'

module.exports =

    'nothing is allowed by default': (test) ->
        list = new Whitelist

        test.ok not list.check 'aslkjdfl'
        test.ok not list.check 'kfdj'
        test.ok not list.check ''

        test.done()

    'simple include': (test) ->
        list = new Whitelist
        list.include 'aaaa'

        test.ok list.check 'aaaa'
        test.ok not list.check 'lkajsdlfjal'
        test.ok not list.check ''

        test.done()

    'simple segment include': (test) ->
        list = new Whitelist
        list.include '/foo/:bar'

        test.ok list.check '/foo/1'
        test.ok list.check '/foo/dklfjdlj'
        test.ok not list.check '/foo/1/bar'
        test.ok not list.check '/foo/'
        test.ok not list.check 'jsldfjl'
        test.ok not list.check ''

        test.done()

    'simple wildcard include': (test) ->
        list = new Whitelist
        list.include '/users/*'

        test.ok list.check '/users/'
        test.ok list.check '/users/1'
        test.ok list.check '/users/dfslkdjfl'
        test.ok list.check '/users/1/djfd'
        test.ok not list.check 'kfdj'
        test.ok not list.check ''

        test.done()

    'simple exclude after including everything': (test) ->
        list = new Whitelist
        list.include '*'
        list.exclude '/users/:id'

        test.ok not list.check '/users/1'
        test.ok not list.check '/users/dfslkdjfl'
        test.ok list.check 'djfsljf'
        test.ok list.check 'jfdl'
        test.ok list.check '/users/1/djfd'
        test.done()

    'selective exclude after include': (test) ->
        list = new Whitelist

        list.include '/projects/*'
        list.exclude '/projects/hidden/*'
        list.exclude '/projects/:id/secret'
        list.include '/users/:id'

        test.ok list.check '/projects/foo/bar/baz'
        test.ok not list.check '/projects/hidden/bar'
        test.ok not list.check '/projects/hidden/bar/baz'
        test.ok not list.check '/projects/5/secret'
        test.ok list.check '/projects/5/secret/foo'
        test.ok not list.check '/users'
        test.ok list.check '/users/5'
        test.ok not list.check '/tasks/57'

        test.done()
