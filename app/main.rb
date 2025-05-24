require 'ruby2d'
require 'artii'
require 'net/http'
require 'uri'
require 'json'
require 'fileutils'

# Constants
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600
SERVER_URL = 'http://localhost:4567'
FONT_PATH = File.join(File.dirname(__FILE__), '..', 'fonts', 'OpenSans-Regular.ttf')
TIMEOUT_SECONDS = 2

# Verify font exists
unless File.exist?(FONT_PATH)
  puts "ERROR: Font file not found at #{FONT_PATH}"
  exit(1)
end

# Initialize window
set title: "ASCII Art Generator"
set width: WINDOW_WIDTH
set height: WINDOW_HEIGHT
set background: 'black'

# Application state
class AppState
  attr_accessor :input_text, :current_font, :status, :cursor_visible
  
  def initialize
    @input_text = ''
    @current_font = 'standard'
    @status = 'Ready'
    @cursor_visible = true
    @mutex = Mutex.new
    @fonts = [
      'standard', 'slant', 'big', 'small', 'smslant', 'bubble',
      'block',  '3-d', 'mini', 'script', 'shadow'
    ]
  end
  
  def next_font
    current_index = @fonts.index(@current_font)
    @current_font = @fonts[(current_index + 1) % @fonts.length]
  end
  
  def prev_font
    current_index = @fonts.index(@current_font)
    @current_font = @fonts[(current_index - 1) % @fonts.length]
  end
  
  def random_font
    @current_font = @fonts.sample
  end
  
  def send_to_server
    @status = 'Generating...'
    Thread.new do
      begin
        uri = URI.parse("#{SERVER_URL}/update")
        http = Net::HTTP.new(uri.host, uri.port)
        http.open_timeout = TIMEOUT_SECONDS
        http.read_timeout = TIMEOUT_SECONDS
        
        request = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
        request.body = { text: @input_text, font: @current_font }.to_json
        
        response = http.request(request)
        
        if response.code == '200'
          @mutex.synchronize { @status = 'Done! View in browser' }
        else
          @mutex.synchronize { @status = "Error: #{response.code}" }
        end
      rescue Net::OpenTimeout, Net::ReadTimeout
        @mutex.synchronize { @status = 'Timeout: Check server' }
      rescue => e
        @mutex.synchronize { @status = "Error: #{e.message}" }
      end
    end
  end
end

# Initialize application state
app = AppState.new

# Cursor blink timer
cursor_timer = Time.now
CURSOR_BLINK_RATE = 0.5 # seconds

# UI Elements
update do
  # Clear screen
  clear
  
  # Title
  Text.new(
    "ASCII Art Generator",
    x: 20, y: 20,
    size: 30,
    color: 'white',
    font: FONT_PATH
  )
  
  # Input field background
  Rectangle.new(
    x: 20, y: 70,
    width: WINDOW_WIDTH - 40,
    height: 40,
    color: 'navy'
  )
  
  # Input text with cursor
  display_text = app.input_text
  if Time.now - cursor_timer > CURSOR_BLINK_RATE
    app.cursor_visible = !app.cursor_visible
    cursor_timer = Time.now
  end
  display_text += '|' if app.cursor_visible
  
  Text.new(
    display_text,
    x: 30, y: 80,
    size: 20,
    color: 'white',
    font: FONT_PATH
  )
  
  # Current font display
  Text.new(
    "Current Font: #{app.current_font}",
    x: 20, y: 130,
    size: 18,
    color: 'lime',
    font: FONT_PATH
  )
  
  # Status display
  Text.new(
    "Status: #{app.status}",
    x: 20, y: WINDOW_HEIGHT - 40,
    size: 18,
    color: 'yellow',
    font: FONT_PATH
  )
  
  # Instructions
  Text.new(
    "Type text and press Enter to generate",
    x: 20, y: WINDOW_HEIGHT - 80,
    size: 16,
    color: 'gray',
    font: FONT_PATH
  )
end

# Keyboard input handling
on :key_down do |event|
  case event.key
  when 'backspace'
    app.input_text = app.input_text[0...-1] if app.input_text.length > 0
    app.status = 'Ready'
  when 'return'
    unless app.input_text.empty?
      app.send_to_server
    end
  when 'up'
    app.prev_font
  when 'down'
    app.next_font
  when 'f'
    app.random_font
  when 'left', 'right'
    # Navigation keys (no action)
  else
    if event.key.length == 1
      app.input_text += event.key
      app.status = 'Ready'
    end
  end
end

# Start the application
show