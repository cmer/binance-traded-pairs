require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'HTTParty'
require 'tty-progressbar'
require 'binance-ruby'
require 'yaml'

config = YAML.load_file('./config.yml')
accounts = config['accounts']
throttle = config['throttle']

# Get all available trading pairs from Binance
response = HTTParty.get "https://api.binance.com/api/v3/ticker/price"
trading_pairs = response.map { |x| x['symbol'] }

puts "Pairs traded by each account:\n"

accounts.each_pair do |account_name, v|
  Binance::Api::Configuration.api_key = v['api_key']
  Binance::Api::Configuration.secret_key = v['secret_key']

  puts "Account: #{account_name}"
  bar = TTY::ProgressBar.new("Querying API [:bar] :elapsed :current/:total (:percent)", total: trading_pairs.count, clear: true, width: 30, hide_cursor: true)

  used_pairs = []
  trading_pairs.each do |pair|
    trades = Binance::Api::Account.trades!(symbol: pair)
    used_pairs << pair unless trades == []
    bar.advance(1)
    sleep(throttle)
  end

  puts "  Trading Pairs: #{used_pairs.sort.join(",")}\n"
end
