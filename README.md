*A short reference (code only) to Design Patterns in Ruby.*

INDEX

1. [Creational Patterns](#1-creational-patterns)
      - [a. Singleton](#a-singleton)
      - [b. Factory](#b-factory)
      - [c. Abstract Factory](#c-abstract-factory)
      - [d. Builder](#d-builder)
      - [e. Prototype](#e-prototype)
  2. [Structural Patterns](#2-structural-patterns)
      - [a. Decorator](#a-decorator)
      - [b. Adapter](#b-adapter)
      - [c. Composite](#c-composite)
      - [d. Proxy](#d-proxy)
      - [e. Bridge](#e-bridge)
      - [f. Facade](#f-facade)
      - [g. Flyweight](#g-flyweight)
  3. [Behavioural Patterns](#3-behavioural-patterns)
      - [a. Observer](#a-observer)
      - [b. Strategy](#b-strategy)
      - [c. Command](#c-command)
      - [d. State](#d-state)
      - [e. Template](#e-template)
      - [f. Iterator](#f-iterator)
      - [g. Mediator](#g-mediator)
      - [h. Chain of Responsibility](#h-chain-of-responsibility)
      - [i. Memento](#i-memento)
      - [j. Visitor](#j-visitor)
      - [k. Interpreter](#k-interpreter)

# 1. Creational Patterns

### a. Singleton

```ruby
require 'singleton'

class Logger
  include Singleton

  def log(message)
    puts "[LOG] #{message}"
  end
end

# Usage
logger1 = Logger.instance
logger2 = Logger.instance

logger1.log("System initialized.")
puts logger1 == logger2  # => true

# Any attempt to use Logger.new will raise an error.
```

### b. Factory

```ruby
# Product classes
class EmailNotification
  def send
    puts "Sending Email Notification"
  end
end

class SMSNotification
  def send
    puts "Sending SMS Notification"
  end
end

# Factory class
class NotificationFactory
  def self.create(type)
    case type
    when :email
      EmailNotification.new
    when :sms
      SMSNotification.new
    else
      raise "Unknown notification type: #{type}"
    end
  end
end

# Usage
notification = NotificationFactory.create(:email)
notification.send  # => Sending Email Notification

notification = NotificationFactory.create(:sms)
notification.send  # => Sending SMS Notification
```

### c. Abstract Factory

```ruby
# Abstract product interfaces
class Button
  def render; end
end

class Checkbox
  def render; end
end

# Concrete products for Mac
class MacButton < Button
  def render
    puts "Rendering Mac-style Button"
  end
end

class MacCheckbox < Checkbox
  def render
    puts "Rendering Mac-style Checkbox"
  end
end

# Concrete products for Windows
class WindowsButton < Button
  def render
    puts "Rendering Windows-style Button"
  end
end

class WindowsCheckbox < Checkbox
  def render
    puts "Rendering Windows-style Checkbox"
  end
end

# Abstract factory
class UIFactory
  def create_button; end
  def create_checkbox; end
end

# Concrete factories
class MacFactory < UIFactory
  def create_button
    MacButton.new
  end

  def create_checkbox
    MacCheckbox.new
  end
end

class WindowsFactory < UIFactory
  def create_button
    WindowsButton.new
  end

  def create_checkbox
    WindowsCheckbox.new
  end
end

# Client code
def render_ui(factory)
  button = factory.create_button
  checkbox = factory.create_checkbox
  button.render
  checkbox.render
end

# Usage
render_ui(MacFactory.new)
render_ui(WindowsFactory.new)
```

### d. Builder

```ruby
# Product class
class Computer
  attr_accessor :cpu, :ram, :storage

  def specs
    "CPU: #{cpu}, RAM: #{ram}, Storage: #{storage}"
  end
end

# Builder class
class ComputerBuilder
  def initialize
    @computer = Computer.new
  end

  def add_cpu(cpu)
    @computer.cpu = cpu
    self
  end

  def add_ram(ram)
    @computer.ram = ram
    self
  end

  def add_storage(storage)
    @computer.storage = storage
    self
  end

  def build
    @computer
  end
end

# Usage
builder = ComputerBuilder.new
my_pc = builder.add_cpu("Intel i9")
              .add_ram("32GB")
              .add_storage("1TB SSD")
              .build

puts my_pc.specs
# => CPU: Intel i9, RAM: 32GB, Storage: 1TB SSD
```

### e. Prototype

```ruby
class Shape
  attr_accessor :type, :color

  def initialize(type, color)
    @type = type
    @color = color
  end

  def clone
    self.dup
  end
end

# Usage
original = Shape.new("Circle", "Red")
copy = original.clone

puts "Original: #{original.type}, #{original.color}"  # => Circle, Red
puts "Copy:     #{copy.type}, #{copy.color}"          # => Circle, Red
puts original == copy                                 # => false (different objects)
```

# 2. Structural Patterns

### a. Decorator
### b. Adapter
### c. Composite
### d. Proxy
### e. Bridge
### f. Facade
### g. Flyweight

# 3. Behavioural Patterns

### a. Observer
### b. Strategy
### c. Command
### d. State
### e. Template
### f. Iterator
### g. Mediator
### h. Chain of Responsibility
### i. Memento
### j. Visitor
### k. Interpreter
