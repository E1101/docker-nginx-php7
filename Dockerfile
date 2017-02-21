# --------------------------------------------------------------------
# | payam/nginx_php7
# | @depends https://github.com/E1101/docker-nginx
# |          /etc/nginx/nginx.conf     ->  nginx config 
# |          /etc/nginx/sites-enabled/ ->  nginx enabled sites
# |
# |
# | Configuration File (php.ini) Path	/etc/php/7.0/fpm
# | Loaded Configuration File	/etc/php/7.0/fpm/php.ini
# | Scan this dir for additional .ini files	/etc/php/7.0/fpm/conf.d
# |

FROM payam/nginx

MAINTAINER Payam Naderi <naderi.payam@gmail.com>

RUN rm /var/lib/apt/lists/* -vrf && \
    apt-get clean && apt-get update
   
RUN DEBIAN_FRONTEND=noninteractive \ 
    && apt-get install -yq --fix-missing \
      apt-utils \ 
      php-fpm \
    && rm -rf /var/lib/apt/lists/*

## extremely insecure setting because it tells PHP to attempt to execute 
#- the closest file it can find if the requested PHP file cannot be found.
RUN sed -i 's/;cgi.fix_pathinfo=0/cgi.fix_pathinfo=0/g' /etc/php/7.0/fpm/php.ini \
    && /etc/init.d/php7.0-fpm start

## default php-fpm enabled config
COPY sites-enabled/ /etc/nginx/sites-enabled/

## copy default www landing page
COPY www/ /var/www/

# Add image configuration and scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh && \
    sed -i -e 's/\r$//' /run.sh

CMD ["/run.sh"]

