Rails.application.routes.draw do
  namespace 'api' do
    post '/tickets', to: 'tickets#post'
    get '/tickets', to: 'tickets#get'
    get '/tickets/:barcode', to: 'tickets#show'
  end
end
