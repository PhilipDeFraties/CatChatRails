Rails.application.config.action_dispatch.cookies_serializer = :hybrid
#config/initializers/session_store.rb
if Rails.env === 'production'
  Rails.application.config.session_store :cookie_store, key: '_CatChatRails', domain: 'CatChatRails-json-api'
else
  Rails.application.config.session_store :cookie_store, key: '_CatChatRails'
end
