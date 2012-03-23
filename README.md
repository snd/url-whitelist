# url-whitelist

create whitelists by including and excluding url patterns and check urls against them

see [url-pattern](https://github.com/snd/url-pattern) for supported url patterns

## Installation

```
npm install git://github.com/snd/url-whitelist.git
```

## Usage

### Require it

```coffeescript
Whitelist = require 'url-whitelist'
```

### Make a new whitelist

```coffeescript
whitelist = new Whitelist
```

### Whitelist a url pattern

```coffeescript
whitelist.include '/users/:id'
```

### Check whether urls are on the whitelist

```coffeescript
whitelist.check '/users/1' # => true
whitelist.check '/projects/1' # => false
```

## Advanced Usage

### Blacklisting

by default a whitelist excludes everything.
to include everything by default and then selectively exclude do:

```coffeescript

blacklist = new Whitelist
blacklist.include '*'

blacklist.exclude '/users/:id'

blacklist.check 'sajdflkasjdfl' # => true
blacklist.check '/users/:id' # => false
blacklist.check 'skljdf' # => true
```

## Example

whitelist `/projects/*` except for `/projects/hidden/*` and `projects/:id/secret`.
also whitelist `/users/:id`

```coffeescript
Whitelist = require 'whitelist'

whitelist = new Whitelist

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

## How check works (pseudocode)

```
whitelisted = false
go through all include- and exclude-patterns in the order they were defined:
    if url matches pattern
        if is include
            whitelisted = true
        else
            whitelisted = false
```

## License

url-whitelist is released under the MIT License (see LICENSE for details).
