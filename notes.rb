require 'sequel'

DB = Sequel.connect($APP_CONFIG['db'])

class Note < Sequel::Model
  def before_create
    self.time ||= Time.now
  end

  def pretty_time
    self.time.strftime("%B %-d, %Y %-l:%M %P")
  end

  def pretty_body
    simple_format self.body
  end
end

get '/notes' do
  @notes = Note.order(:time.desc)
  @stylesheets = ['notes']
  @javascripts = ['notes']
  erb :notes
end

get '/notes/:id' do
  @note = Note.find(params[:id])
end

post '/notes' do
  note = Note.new({
    :body => params['body'],
    :author => params['author'],
    :address => request.env['REMOTE_ADDR']
  })
  note.save
  content_type :json
  layout false
  {
    :body => note.pretty_body,
    :author => note.author,
    :time => note.pretty_time
  }.to_json
end
