FROM fluent/fluentd:v1.11-1

# Use root account to use apk
USER root

RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && sudo gem install fluent-plugin-cloudwatch-logs \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY fluent.conf /fluentd/etc/
COPY entrypoint.sh /bin/

ENV AWS_REGION="us-east-1"
ENV AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY"
ENV AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY"

USER fluent