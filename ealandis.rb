ENV['GEM_PATH'] = File.expand_path('~/.gems') + ':/usr/lib/ruby/gems/1.8'

require 'bundler/setup'
require 'rubygems'
require 'sinatra'
require 'json'
require 'yaml'
require 'sanitize'

$APP_CONFIG = YAML.load_file(File.join(File.dirname(__FILE__), 'config.yml'))

require './helpers'
require './notes'

get '/' do
  @javascripts = ['cufon', 'monsieur', 'home']
  erb :index
end

get '/gallery' do
  @stylesheets = ['galleria.classic', 'gallery']
  @javascripts = ['galleria-1.2.6.min', 'galleria.classic.min', 'gallery']
  @no_footer = true
  erb :gallery
end

get '/images.json' do
  content_type :json
  layout false
  get_images.to_json
end

private
def get_images
  unless defined? @@images
    @@images = Dir.glob(File.join(File.dirname(__FILE__), 'public/img/gallery/full/*')).sort.map do |img|
      {
        :thumb => get_resized(img),
        :image => get_resized(img, 'normal'),
        :big => get_resized(img, 'full'),
      }
    end
  end
  @@images
end

def get_resized(path, size = 'thumb')
  path.sub('full', size).sub(/.*public/, '')
end

