server {
    listen 80 default_server;
    listen [::]:80 default_server;

    server_name preprod.kalaxia.com;

    return 302 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;

    ssl_certificate /etc/ssl/live/preprod.kalaxia.com/fullchain.pem;
    ssl_certificate_key /etc/ssl/live/preprod.kalaxia.com/privkey.pem;

    server_name preprod.kalaxia.com;

    access_log /var/log/nginx/https_kalaxia_game.access.log;
    error_log /var/log/nginx/https_kalaxia_game.error.log;

    merge_slashes on;

    location /api {
        proxy_http_version 1.1;
        proxy_pass http://kalaxia_api;
        proxy_set_header        Host            $host;
        proxy_set_header        X-Real-IP       $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Scheme        $scheme;
        proxy_set_header        Connection "";
        proxy_buffering off;
        proxy_ignore_client_abort on;
        proxy_read_timeout 7d;
        proxy_send_timeout 7d;
    }

    location / {
        proxy_http_version 1.1;
        proxy_pass http://kalaxia_front:3000;
        proxy_set_header        Host            $host;
        proxy_set_header        X-Real-IP       $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Scheme        $scheme;
        proxy_set_header        Connection "";
        proxy_buffering off;
        proxy_ignore_client_abort on;
        proxy_read_timeout 7d;
        proxy_send_timeout 7d;
    }

    location ~ /\.ht {
        deny all;
    }

    location ~ /public/log/stats/ {
        deny all;
    }
}
