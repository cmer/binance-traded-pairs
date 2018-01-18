require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'HTTParty'
require 'binance-ruby'
require 'byebug'
accounts = {
  bot: ['rZMbpkXYTovynkWTX2z4n7NDo8VgUqb1KyyuWJ9mlZ8y4JWFx2pfeRMfFnehSDZo', 'DoSFydhOY8zmjZJtm3MEqP1cSdsNdvu4mnzKLYOYrr26LJDOqffmXruzici8N4Wt']
}

x = 'ARNETH'

accounts.each_pair do |account_name, v|
  Binance::Api::Configuration.api_key = v.first
  Binance::Api::Configuration.secret_key = v.last
  trades = Binance::Api::Account.trades!(symbol: x)
  byebug
end
