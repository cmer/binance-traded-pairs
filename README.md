# Binance Trading Pairs

This is a simple Ruby script that retrieves all the pairs you've traded on Binance. It supports multiple accounts and simple throttling to avoid getting banned by Binance's API.

### Getting Started

This assumes that you already have Ruby 2.4+ and Bundler installed.

```bash
$ cp config.yml.example config.yml
# --> Edit config.yml and put your api key and secret. Delete the second account if not needed.
$ bundle
$ ruby run.rb
```
