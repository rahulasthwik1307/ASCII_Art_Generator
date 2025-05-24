require 'sinatra'
# Remove this line: require 'sinatra/streaming'
require 'json'
require 'artii'
require 'clipboard'
require 'fileutils'

# Configuration
set :server, 'webrick' # Change this line
set :port, 4567
set :bind, 'localhost'
set :public_folder, File.join(File.dirname(__FILE__), '..', 'public')
set :views, File.join(File.dirname(__FILE__), '..', 'views')

# Verify font exists
font_path = File.join(File.dirname(__FILE__), '..', 'fonts', 'OpenSans-Regular.ttf')
unless File.exist?(font_path)
  puts "ERROR: Font file not found at #{font_path}"
  exit(1)
end

# Store the latest ASCII art
$latest_ascii = {
  text: '',
  font: 'standard',
  ascii: ''
}

# Main page
get '/' do
  erb :index
end

# Modified SSE endpoint without streaming
get '/updates' do
  content_type 'text/event-stream'
  "data: #{$latest_ascii.to_json}\n\n"
end

# Generate ASCII art endpoint
post '/update' do
  content_type :json
  
  begin
    # Parse request body
    request_payload = JSON.parse(request.body.read)
    text = request_payload['text'].to_s
    font = request_payload['font'].to_s
    
    # Validate input
    if text.empty?
      status 400
      return { error: 'Text cannot be empty' }.to_json
    end
    
    # Generate ASCII art
    artii = Artii::Base.new(font: font)
    ascii = artii.asciify(text)
    
    # Update latest ASCII art
    $latest_ascii = {
      text: text,
      font: font,
      ascii: ascii
    }
    
    # Return success
    { success: true }.to_json
  rescue => e
    status 500
    { error: e.message }.to_json
  end
end