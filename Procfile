application: puma -b tcp://10.10.0.77:3000 -t 4:24
realtime: rake websocket_rails:start_server
background: sidekiq -C config/sidekiq.yml
