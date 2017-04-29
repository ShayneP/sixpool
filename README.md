## Sixpool

Sixpool is a basic, easy to use solution for creating and managing a threadpool in Ruby. It uses Starcraft terminology.
It's useful for avoiding head of line blocking of big HTTP requests or API calls, but for quick operations you're better off not using
a managed thread pool, and just letting Ruby do it's own thing.

### Example usage

```
# Before threading

require 'httparty'
100.times do 
  HTTParty.get('https://www.warcraftlogs.com/rankings/11#boss=1862')
end

# Takes about 40s on a 2016 Macbook Pro
```

```
# After threading
require 'httparty'
require 'sixpool'

# This creates a new thread pool, size 12. The default is 6.
zerglings = Sixpool.new(12)
100.times do
  zerglings.attack do
    HTTParty.get('https://www.warcraftlogs.com/rankings/11#boss=1862')
  end
end
# This cleans up the thread pool, and finishes all remaining work before killing off the processes.
zerglings.gg

# Takes about 4s on a 2016 Macbook Pro
```
