Rails.application.routes.draw do
  namespace 'api' do
    post '/tickets', to: 'tickets#post'
    get '/tickets', to: 'tickets#get'
  end
end
