Rails.application.routes.draw do
  namespace 'api' do
    post '/tickets', to: 'tickets#post'
    get '/tickets', to: 'tickets#get'
    get '/tickets/:barcode', to: 'tickets#show'
    post '/tickets/:barcode/payments', to: 'tickets#pay'
    get '/tickets/:barcode/state', to: 'tickets#state'
  end
end
