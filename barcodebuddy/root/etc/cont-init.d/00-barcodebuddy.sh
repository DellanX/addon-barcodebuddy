#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Grocy
# Sets up Grocy before the server starts
# ==============================================================================
if ! bashio::fs.directory_exists "/data/bbuddy"; then
    bashio::log.debug 'Data directory not initialized, doing that now...'

    # Setup structure
    cp -R /app/bbuddy/data /data/bbuddy

    # Ensure file permissions
    chown -R nginx:nginx /data
    find /data/bbuddy -not -perm 0644 -type f -exec chmod 0644 {} \;
    find /data/bbuddy -not -perm 0755 -type d -exec chmod 0755 {} \;
fi


bashio::log.debug 'Symlinking data directory to persistent storage location...'
rm -f -r /app/bbuddy/data
ln -s /data/bbuddy /app/bbuddy/data