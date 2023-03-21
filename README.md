# DSL Intro - DevDev

## What is the thing?

- Domain-Specific Language
- Methods and classes in Ruby that when used, act like a whole extra layer over the existing language
- Examples: Rails' routes, RSpec Describes, Contexts and Its

## How is the thing useful?

- Condenses boilerplate code down to something readable
- Repeated blocks are much easier to read, and allow you to wrap up extra context that might not be clear from the verbose version

## How is the thing a pain?

- Framework specific: Similar idea to Ruby vs ActiveSupport. If it's all someone has ever used, doing something outside that framework can be a shock
- Company specific: Leads to a lot of internal knowledge and a steeper learning curve for new joiners (see *.rbapi in the main app)

## Do the things

### Start `irb`

```bash
irb
```

### Run the things

```ruby
SymbolizeKeys.call(data: { 'one' => 1 })
SymbolizeKeys.call(data: { 'one' => 1, 'two' => { 'nested' => 'string', also: :symbols }})
SymbolizeKeys.call(data: { 'one' => 1, 'two' => { 'nested' => 'string', also: :symbols }}, deep_symbolize: true)
```
