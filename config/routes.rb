Rails.application.routes.draw do

 root 'robot#index', via: [:get, :post]

end
