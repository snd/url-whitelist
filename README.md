# url-whitelist (DISCONTINUED!)

[![Build Status](https://travis-ci.org/snd/url-whitelist.png)](https://travis-ci.org/snd/url-whitelist)

url-whitelist can create whitelists by including and excluding url patterns and check urls against them

see [url-pattern](https://github.com/snd/url-pattern) for supported url patterns

### install

```
npm install url-whitelist
```

### use

##### require

```coffeescript
newWhitelist = require 'url-whitelist'
```

##### make a new whitelist

```coffeescript
whitelist = newWhitelist()
```

##### whitelist a url pattern

```coffeescript
whitelist.include '/users/:id'
```

##### check whether urls are on the whitelist

```coffeescript
whitelist.check '/users/1' # => true
whitelist.check '/projects/1' # => false
```

##### blacklisting

by default a whitelist excludes everything.
you can include everything by default and then selectively exclude patterns.

```coffeescript

blacklist = newWhitelist()
blacklist.include '*'

blacklist.exclude '/users/:id'

blacklist.check 'sajdflkasjdfl' # => true
blacklist.check '/users/:id' # => false
blacklist.check 'skljdf' # => true
```

### example

whitelist `/projects/*` except for `/projects/hidden/*` and `projects/:id/secret`.
also whitelist `/users/:id`

```coffeescript
newWhitelist = require 'url-whitelist'

whitelist = newWhitelist()

whitelist.include '/projects/*'
whitelist.exclude '/projects/hidden/*'
whitelist.exclude '/projects/:id/secret'
whitelist.include '/users/:id'

whitelist.check '/projects/foo/bar/baz' # => true
whitelist.check '/projects/hidden/bar/baz' # => false
whitelist.check '/projects/5/secret' # => false
whitelist.check '/projects/5/secret/foo' # => true

whitelist.check '/users' # => false
whitelist.check '/users/5' # => true

whitelist.check '/tasks/57' # => false
```

### how check works (pseudocode)

```
whitelisted = false
go through all include- and exclude-patterns in the order they were defined:
    if url matches pattern
        if is include
            whitelisted = true
        else
            whitelisted = false
```

### license: MIT
