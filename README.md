*A short reference (code only) to Design Patterns in Ruby.*

INDEX

1. [x] [Creational Patterns](#1-creational-patterns)
      - [x] [a. Singleton](#a-singleton)
      - [x] [b. Factory](#b-factory)
      - [x] [c. Abstract Factory](#c-abstract-factory)
      - [x] [d. Builder](#d-builder)
      - [x] [e. Prototype](#e-prototype)
  2. [Structural Patterns](#2-structural-patterns)
      - [ ] [a. Decorator](#a-decorator)
      - [ ] [b. Adapter](#b-adapter)
      - [ ] [c. Composite](#c-composite)
      - [ ] [d. Proxy](#d-proxy)
      - [ ] [e. Bridge](#e-bridge)
      - [ ] [f. Facade](#f-facade)
      - [ ] [g. Flyweight](#g-flyweight)
  3. [Behavioural Patterns](#3-behavioural-patterns)
      - [ ] [a. Observer](#a-observer)
      - [ ] [b. Strategy](#b-strategy)
      - [ ] [c. Command](#c-command)
      - [ ] [d. State](#d-state)
      - [ ] [e. Template](#e-template)
      - [ ] [f. Iterator](#f-iterator)
      - [ ] [g. Mediator](#g-mediator)
      - [ ] [h. Chain of Responsibility](#h-chain-of-responsibility)
      - [ ] [i. Memento](#i-memento)
      - [ ] [j. Visitor](#j-visitor)
      - [ ] [k. Interpreter](#k-interpreter)

---

## Descriptions

### 1. Creational Patterns

These focus on object creation and initialization.

| Pattern | Purpose |
|---|---|
| Singleton | Ensures a class has only one instance (e.g., config manager). One instance globally accessible. |
| Factory | Creates objects without specifying the exact class. Delegates instantiation to subclasses. |
| Abstract Factory | Produces families of related objects without specifying concrete classes. |
| Builder | Constructs complex objects step-by-step. |
| Prototype | Clones existing objects instead of creating new ones. |

### 2. Structural Patterns

These deal with object composition and relationships.

| Pattern | Purpose |
|---|---|
| Decorator | Adds responsibilities/behavior to objects dynamically. |
| Adapter | Converts one interface to another (great for legacy integration). |
| Composite | Treats individual objects and compositions (composite objects) uniformly. |
| Proxy | Controls access to another object (e.g., lazy loading, logging). |
| Bridge | Decouples abstraction from implementation. |
| Facade | Simplifies complex subsystems with a unified interface. |
| Flyweight | Shares common state between many objects to save memory. |

### 3. Behavioral Patterns

These focus on communication between objects.

| Pattern | Purpose |
|---|---|
| Observer | Notifies dependent objects of state changes (ideal for event systems). |
| Strategy | Selects an algorithm at runtime. |
| Command | Encapsulates requests as objects. |
| State | Allows an object to alter its behavior when its internal state changes. |
| Template | Defines the skeleton of an algorithm, deferring steps to subclasses. |
| Iterator | Sequential access to elements. |
| Mediator | Centralizes communication between objects. |
| Chain of Responsibility | Passes request along a chain until handled. |
| Memento | Captures and restores object state. |
| Visitor | Adds operations to objects without modifying them. |
| Interpreter | Implements a grammar interpreter. |

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

logger3 = Logger.new # Raises NoMethodError

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

```ruby
# Base Component
class Text
  def content
    "Hello, Pete!"
  end
end


# Decorators (Each decorator wraps the base object and adds behavior.)
class BoldDecorator
  def initialize(component)
    @component = component
  end

  def content
    "<b>#{@component.content}</b>"
  end
end

class ItalicDecorator
  def initialize(component)
    @component = component
  end

  def content
    "<i>#{@component.content}</i>"
  end
end

# Usage
text = Text.new
bold_text = BoldDecorator.new(text)
italic_bold_text = ItalicDecorator.new(bold_text)

puts italic_bold_text.content
# => "<i><b>Hello, Pete!</b></i>"
```

### b. Adapter

```ruby
# Legacy Class (Incompatible Interface)
class LegacyFahrenheitSensor
  def read_fahrenheit
    98.6
  end
end

# Adapter Class
class CelsiusAdapter
  def initialize(sensor)
    @sensor = sensor
  end

  def read_celsius
    fahrenheit = @sensor.read_fahrenheit
    ((fahrenheit - 32) * 5.0 / 9.0).round(2)
  end
end

# Usage
legacy_sensor = LegacyFahrenheitSensor.new
adapter = CelsiusAdapter.new(legacy_sensor)

puts adapter.read_celsius
# => 37.0
```
### c. Composite

```ruby
# Base Component Interface
class MenuComponent
  def display
    raise NotImplementedError
  end
end

# Leaf Class (Individual Item)
class MenuItem < MenuComponent
  def initialize(name)
    @name = name
  end

  def display
    puts @name
  end
end

# Composite Class (Group of Items)
class Menu < MenuComponent
  def initialize(name)
    @name = name
    @items = []
  end

  def add(item)
    @items << item
  end

  def display
    puts "Menu: #{@name}"
    @items.each(&:display)
  end
end

# Usage
main_menu = Menu.new("Main")
breakfast = Menu.new("Breakfast")
lunch = Menu.new("Lunch")

breakfast.add(MenuItem.new("Pancakes"))
breakfast.add(MenuItem.new("Coffee"))

lunch.add(MenuItem.new("Burger"))
lunch.add(MenuItem.new("Fries"))

main_menu.add(breakfast)
main_menu.add(lunch)

main_menu.display

# => Menu: Main
# => Menu: Breakfast
# => Pancakes
# => Coffee
# => Menu: Lunch
# => Burger
# => Fries
```

### d. Proxy

```ruby
# Real Object
class RealObject
  def greet
    "Hello from the real object!"
  end
end

# Proxy Class
class ProxyObject
  def initialize(real_object)
    @real_object = real_object
  end

  def greet
    puts "Proxy: Checking access..."
    @real_object.greet
  end
end

# Usage
real = RealObject.new
proxy = ProxyObject.new(real)

puts proxy.greet

# => Proxy: Checking access...
# => Hello from the real object!
```

### e. Bridge

```ruby
# Step 1: Define the Implementation Interface
class Renderer
  def render_circle(radius)
    raise NotImplementedError
  end
end

# Step 2: Concrete Implementations
class SVGRenderer < Renderer
  def render_circle(radius)
    "<circle r='#{radius}' />"
  end
end

class CanvasRenderer < Renderer
  def render_circle(radius)
    "Drawing circle with radius #{radius} on canvas"
  end
end

# Step 3: Abstraction Layer
class Shape
  def initialize(renderer)
    @renderer = renderer
  end
end

class Circle < Shape
  def initialize(renderer, radius)
    super(renderer)
    @radius = radius
  end

  def draw
    @renderer.render_circle(@radius)
  end
end

# Usage
svg = SVGRenderer.new
canvas = CanvasRenderer.new

circle1 = Circle.new(svg, 10)
circle2 = Circle.new(canvas, 20)

puts circle1.draw  # => "<circle r='10' />"
puts circle2.draw  # => "Drawing circle with radius 20 on canvas"

# => <circle r='10' />
# => Drawing circle with radius 20 on canvas
```

### f. Facade

```ruby
# Subsystem Classes (Complex Internals)
class EmailService
  def send_welcome_email(name, email)
    puts "Email sent to #{email}: Welcome, #{name}!"
  end
end

class LoggerService
  def log(message)
    puts "LOG: #{message}"
  end
end

class AnalyticsService
  def track(event)
    puts "Analytics tracked: #{event}"
  end
end

# Facade Class
class UserOnboardingFacade
  def initialize(name, email)
    @name = name
    @email = email
    @email_service = EmailService.new
    @logger = LoggerService.new
    @analytics = AnalyticsService.new
  end

  def onboard
    @email_service.send_welcome_email(@name, @email)
    @logger.log("User onboarded: #{@name}")
    @analytics.track("user_signup")
  end
end

# Usage
facade = UserOnboardingFacade.new("Xlen", "xlen@example.com")
facade.onboard

# => Email sent to xlen@example.com: Welcome, Xlen!
# => LOG: User onboarded: Xlen
# => Analytics tracked: user_signup
```

### g. Flyweight

```ruby
# Flyweight Class (Shared Intrinsic State)
class CharacterFlyweight
  def initialize(char)
    @char = char
  end

  def render(position, font_size)
    puts "Rendering '#{@char}' at #{position} with font size #{font_size}"
  end
end

# Flyweight Factory
class CharacterFactory
  def initialize
    @pool = {}
  end

  def get_character(char)
    @pool[char] ||= CharacterFlyweight.new(char)
  end
end

# Usage
factory = CharacterFactory.new

positions = [[0,0], [1,0], [2,0]]
text = "AAA"

text.chars.each_with_index do |char, i|
  flyweight = factory.get_character(char)
  flyweight.render(positions[i], 12)
end

# => Rendering 'A' at [0, 0] with font size 12
# => Rendering 'A' at [1, 0] with font size 12
# => Rendering 'A' at [2, 0] with font size 12
```

# 3. Behavioural Patterns

### a. Observer

```ruby
# Subject (Observable)
class WeatherStation
  def initialize
    @observers = []
    @temperature = nil
  end

  def add_observer(observer)
    @observers << observer
  end

  def set_temperature(temp)
    @temperature = temp
    notify_observers
  end

  private

  def notify_observers
    @observers.each { |observer| observer.update(@temperature) }
  end
end

# Observer Classes
class PhoneDisplay
  def update(temp)
    puts "Phone Display: Temperature is now #{temp}°C"
  end
end

class LEDDisplay
  def update(temp)
    puts "LED Display: Temperature updated to #{temp}°C"
  end
end

# Usage
station = WeatherStation.new
phone = PhoneDisplay.new
led = LEDDisplay.new

station.add_observer(phone)
station.add_observer(led)

station.set_temperature(28)
station.set_temperature(31)

# => Phone Display: Temperature is now 28°C
# => LED Display: Temperature updated to 28°C
# => Phone Display: Temperature is now 31°C
# => LED Display: Temperature updated to 31°C
```

### b. Strategy

```ruby
# Step 1: Strategy Interface
class DiscountStrategy
  def apply(amount)
    raise NotImplementedError
  end
end

# Step 2: Concrete Strategies
class NoDiscount < DiscountStrategy
  def apply(amount)
    amount
  end
end

class TenPercentDiscount < DiscountStrategy
  def apply(amount)
    amount * 0.9
  end
end

class FixedAmountDiscount < DiscountStrategy
  def apply(amount)
    amount - 50
  end
end

# Step 3: Context Class
class ShoppingCart
  def initialize(strategy)
    @strategy = strategy
  end

  def checkout(total)
    @strategy.apply(total)
  end
end

# Usage
cart1 = ShoppingCart.new(NoDiscount.new)
cart2 = ShoppingCart.new(TenPercentDiscount.new)
cart3 = ShoppingCart.new(FixedAmountDiscount.new)

puts cart1.checkout(500)  # => 500.0
puts cart2.checkout(500)  # => 450.0
puts cart3.checkout(500)  # => 450
```

### c. Command

```ruby
# Receiver (The Actual Logic)
class Light
  def turn_on
    puts "Light is ON"
  end

  def turn_off
    puts "Light is OFF"
  end
end

# Command Interface
class Command
  def execute
    raise NotImplementedError
  end
end

# Concrete Commands
class TurnOnCommand < Command
  def initialize(light)
    @light = light
  end

  def execute
    @light.turn_on
  end
end

class TurnOffCommand < Command
  def initialize(light)
    @light = light
  end

  def execute
    @light.turn_off
  end
end

# Invoker (Remote Control)
class RemoteControl
  def initialize
    @commands = []
  end

  def add_command(command)
    @commands << command
  end

  def run
    @commands.each(&:execute)
  end
end

# Usage
light = Light.new

on_command = TurnOnCommand.new(light)
off_command = TurnOffCommand.new(light)

remote = RemoteControl.new
remote.add_command(on_command)
remote.add_command(off_command)

remote.run

# => Light is ON
# => Light is OFF
```

### d. State

```ruby
# State Interface
class TrafficLightState
  def next(light)
    raise NotImplementedError
  end

  def show
    raise NotImplementedError
  end
end

# Concrete States
class Red < TrafficLightState
  def next(light)
    light.state = Green.new
  end

  def show
    "Red Light – Stop"
  end
end

class Green < TrafficLightState
  def next(light)
    light.state = Yellow.new
  end

  def show
    "Green Light – Go"
  end
end

class Yellow < TrafficLightState
  def next(light)
    light.state = Red.new
  end

  def show
    "Yellow Light – Slow Down"
  end
end

# Context Class
class TrafficLight
  attr_accessor :state

  def initialize
    @state = Red.new
  end

  def change
    @state.next(self)
  end

  def display
    @state.show
  end
end

# Usage
light = TrafficLight.new

3.times do
  puts light.display
  light.change
end

# => Red Light – Stop
# => Green Light – Go
# => Yellow Light – Slow Down
```

### e. Template

```ruby
# Step 1: Abstract Template Class
class Beverage
  def prepare
    boil_water
    brew
    pour_in_cup
    add_condiments
  end

  def boil_water
    puts "Boiling water"
  end

  def pour_in_cup
    puts "Pouring into cup"
  end

  def brew
    raise NotImplementedError
  end

  def add_condiments
    raise NotImplementedError
  end
end

# Step 2: Concrete Subclasses
class Tea < Beverage
  def brew
    puts "Steeping the tea"
  end

  def add_condiments
    puts "Adding lemon"
  end
end

class Coffee < Beverage
  def brew
    puts "Dripping coffee through filter"
  end

  def add_condiments
    puts "Adding sugar and milk"
  end
end

# Usage
puts "Tea:"
Tea.new.prepare

puts "\nCoffee:"
Coffee.new.prepare

# => Tea:
# => Boiling water
# => Steeping the tea
# => Pouring into cup
# => Adding lemon
# => 
# => Coffee:
# => Boiling water
# => Dripping coffee through filter
# => Pouring into cup
# => Adding sugar and milk
```

### f. Iterator

```ruby
# Step 1: Collection Class
class NameCollection
  def initialize
    @names = []
  end

  def add(name)
    @names << name
  end

  def iterator
    NameIterator.new(@names)
  end
end

# Step 2: Iterator Class
class NameIterator
  def initialize(names)
    @names = names
    @index = 0
  end

  def has_next?
    @index < @names.length
  end

  def next
    name = @names[@index]
    @index += 1
    name
  end
end

# Usage
collection = NameCollection.new
collection.add("Xlen")
collection.add("Ava")
collection.add("Leo")

iterator = collection.iterator

while iterator.has_next?
  puts iterator.next
end

# => Xlen
# => Ava
# => Leo
```

### g. Mediator

```ruby
# Step 1: Mediator Class
class ChatRoom
  def show_message(user, message)
    puts "#{user.name}: #{message}"
  end
end

# Step 2: Colleague Class (User)
class User
  attr_reader :name

  def initialize(name, chatroom)
    @name = name
    @chatroom = chatroom
  end

  def send_message(message)
    @chatroom.show_message(self, message)
  end
end

# Usage
chatroom = ChatRoom.new

glen = User.new("Glen", chatroom)
ava  = User.new("Ava", chatroom)

glen.send_message("Hey Ava, ready for sonar testing?")
ava.send_message("Absolutely, Glen. Let’s ping some whales!")

# => Glen: Hey Ava, ready for sonar testing?
# => Ava: Absolutely, Glen. Let’s ping some whales!
```

### h. Chain of Responsibility

```ruby
# Step 1: Handler Base Class
class Handler
  attr_accessor :next_handler

  def initialize
    @next_handler = nil
  end

  def set_next(handler)
    @next_handler = handler
    handler
  end

  def handle(request)
    if @next_handler
      @next_handler.handle(request)
    else
      puts "End of chain. No handler processed the request."
    end
  end
end

# Step 2: Concrete Handlers
class EmailValidator < Handler
  def handle(request)
    if request[:email].include?("@")
      puts "Email is valid"
      super(request)
    else
      puts "Invalid email"
    end
  end
end

class PasswordValidator < Handler
  def handle(request)
    if request[:password].length >= 6
      puts "Password is valid"
      super(request)
    else
      puts "Password too short"
    end
  end
end

class AgeValidator < Handler
  def handle(request)
    if request[:age] >= 18
      puts "Age is valid"
      super(request)
    else
      puts "User is underage"
    end
  end
end

# Usage
# Build the chain
email = EmailValidator.new
password = PasswordValidator.new
age = AgeValidator.new

email.set_next(password).set_next(age)

# Test request
request = { email: "glen@example.com", password: "secret123", age: 31 }
email.handle(request)

# => Email is valid
# => Password is valid
# => Age is valid
# => End of chain. No handler processed the request.
```

### i. Memento

```ruby
# 1. Originator (The object whose state we want to save)
class TextEditor
  attr_accessor :content

  def initialize
    @content = ""
  end

  def write(text)
    @content += text
  end

  def save
    Memento.new(@content)
  end

  def restore(memento)
    @content = memento.content
  end
end

# 2. Memento (Stores the state)
class Memento
  attr_reader :content

  def initialize(content)
    @content = content
  end
end

# 3. Caretaker (Manages saved states)
class History
  def initialize
    @stack = []
  end

  def push(memento)
    @stack << memento
  end

  def pop
    @stack.pop
  end
end

# Usage
editor = TextEditor.new
history = History.new

editor.write("Hello, ")
history.push(editor.save)

editor.write("Glen!")
history.push(editor.save)

puts editor.content  # => "Hello, Glen!"

# Undo last write
editor.restore(history.pop)
puts editor.content  # => "Hello, "

# Undo again
editor.restore(history.pop)
puts editor.content  # => ""
```

### j. Visitor

```ruby
# Step 1: Visitor Interface
class ShapeVisitor
  def visit_circle(circle)
    raise NotImplementedError
  end

  def visit_rectangle(rectangle)
    raise NotImplementedError
  end
end

# Step 2: Element Interface
class Shape
  def accept(visitor)
    raise NotImplementedError
  end
end

# Concrete Elements
class Circle < Shape
  attr_reader :radius

  def initialize(radius)
    @radius = radius
  end

  def accept(visitor)
    visitor.visit_circle(self)
  end
end

class Rectangle < Shape
  attr_reader :width, :height

  def initialize(width, height)
    @width = width
    @height = height
  end

  def accept(visitor)
    visitor.visit_rectangle(self)
  end
end

# Concrete Visitor
class AreaCalculator < ShapeVisitor
  def visit_circle(circle)
    area = Math::PI * circle.radius**2
    puts "Circle area: #{area.round(2)}"
  end

  def visit_rectangle(rectangle)
    area = rectangle.width * rectangle.height
    puts "Rectangle area: #{area}"
  end
end

# Usage
shapes = [
  Circle.new(5),
  Rectangle.new(4, 6)
]

visitor = AreaCalculator.new

shapes.each { |shape| shape.accept(visitor) }

# => Circle area: 78.54
# => Rectangle area: 24
```

### k. Interpreter

```ruby
# Step 1: Abstract Expression
class Expression
  def interpret
    raise NotImplementedError
  end
end

# Step 2: Terminal Expressions
class Number < Expression
  def initialize(value)
    @value = value
  end

  def interpret
    @value
  end
end

class Add < Expression
  def initialize(left, right)
    @left = left
    @right = right
  end

  def interpret
    @left.interpret + @right.interpret
  end
end

class Subtract < Expression
  def initialize(left, right)
    @left = left
    @right = right
  end

  def interpret
    @left.interpret - @right.interpret
  end
end

# Usage
# Represents: 5 + (10 - 3)
expr = Add.new(
  Number.new(5),
  Subtract.new(Number.new(10), Number.new(3))
)

puts expr.interpret  # => 12
```