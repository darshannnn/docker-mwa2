FROM alpine

ENV APP_DIR /app

COPY docker/requirements.txt /tmp/

RUN apk add --update python py-pip libpq git
RUN apk --update add --virtual build-dependencies python2-dev build-base wget openldap-dev \
  && pip install -r /tmp/requirements.txt \
  && git clone https://github.com/munki/mwa2.git /app \
  && git clone https://github.com/munki/munki.git \
  && git config --global user.email "mwa@github.com \
  && git config --global user.name "Munki Web Admin" \
  && mkdir -p /usr/local/munki \
  && mv /munki/code/client/makecatalogs /usr/local/munki/makecatalogs \
  && rm -rf /munki \
  && apk del build-dependencies \
  && rm -rf /var/cache/apk/*


COPY docker/run.sh /usr/sbin/
COPY docker/settings.py /app/munkiwebadmin/
COPY docker/django_wsgiserver /app/django_wsgiserver/
COPY docker/admin_tools/ /app/admin_tools/

WORKDIR /app
#
ENTRYPOINT ["/bin/sh", "/usr/sbin/run.sh"]
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
