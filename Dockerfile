# --------------------------------------------------------------------
# | payam/nginx_php7
# | @depends https://github.com/E1101/docker-nginx
# | 
# |

FROM payam/nginx

MAINTAINER Payam Naderi <naderi.payam@gmail.com>

RUN rm /var/lib/apt/lists/* -vrf && \
    apt-get clean && apt-get update
   
RUN DEBIAN_FRONTEND=noninteractive \ 
    && apt-get install -yq --fix-missing --force-yes \
       php-fpm \
    && rm -rf /var/lib/apt/lists/*

## extremely insecure setting because it tells PHP to attempt to execute 
#- the closest file it can find if the requested PHP file cannot be found.
## /etc/php/7.0/fpm/php.ini ----> cgi.fix_pathinfo=0

## copy sites enabled default

#  command override, change mount config
## service nginx reload
## or here
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]

