#!/usr/bin/env bashio

bashio::log.info "Exporting log level for nodejs: $(bashio::config log_level)"
export NODE_CONSOLE_LOG_LEVEL=`bashio::config log_level`

bashio::log.info "Symlinking data dir"
rm -rf /app/data
ln -s /data /app

bashio::log.info "Running 'eval' commands"
eval $(bashio::config eval)

bashio::log.info "Generating config.yml from options.json"
echo '# Generated by homeassistant, do not edit!' > /app/data/config.yml
echo '# Edit configuration only at the Add-on configuration tab!' >> /app/data/config.yml
json2yml /data/options.json >> /app/data/config.yml

bashio::log.info "Image build with version $(cat /version)"
bashio::log.info "starting original stuff... 123"
npm run verbose
