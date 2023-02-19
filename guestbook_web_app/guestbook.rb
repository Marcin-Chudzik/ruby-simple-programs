require 'sinatra'
require 'sinatra/reloader'
require 'sequel'

DB = Sequel.sqlite "database.db"


get '/' do
    posts = DB[:posts]
    erb :index, locals: { posts: posts.order(Sequel.desc(:created_at)) }
end


post '/messages' do
    posts = DB[:posts]
    posts.insert(
        author: params[:author],
        content: params[:content],
        created_at: Time.now
    )
    redirect '/'
end