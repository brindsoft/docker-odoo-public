FROM ubuntu:20.04
MAINTAINER Brindsoft Technologies <info@brindsoft.com>

# Generate locale C.UTF-8 for postgres and general locale data
ENV LANG C.UTF-8
# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN apt-get update && apt-get install -y tzdata
RUN set -x; \
	apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        dirmngr \
        fonts-noto-cjk \
        gnupg \
        libssl-dev \
        node-less \
        npm \
        python3-num2words \
        python3-pdfminer \
        python3-pip \
        python3-phonenumbers \
        python3-pyldap \
        python3-qrcode \
        python3-renderpm \
        python3-setuptools \
        python3-slugify \
        python3-vobject \
        python3-watchdog \
        python3-xlrd \
        python3-xlwt \
        xz-utils \
        # START wkhtmltopdf dependencies
        libxrender1 \
        fontconfig \
        xvfb \
        # END wkhtmltopdf dependencies
        # START Extra packages to be installed with apt get
        build-essential \
        locales \
        python3-dev \
        libpq-dev \
        libldap2-dev \
        libsasl2-dev \
        python3-pip \
    	vim \
   	git \
   	sudo \
    	ssh
        # END Extra packages to be installed with apt get

## gnerate locale used in addons to tranlsate currency and days
#RUN locale-gen "pt_BR.utf8"

## Install wkhtmltopdf
RUN curl -o wkhtmltox.tar.xz -SL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
    && echo '3f923f425d345940089e44c1466f6408b9619562 wkhtmltox.tar.xz' | sha1sum -c - \
    && tar xvf wkhtmltox.tar.xz \
    && cp wkhtmltox/lib/* /usr/local/lib/ \
    && cp wkhtmltox/bin/* /usr/local/bin/ \
    && cp -r wkhtmltox/share/man/man1 /usr/local/share/man/
## Upgrade pip
RUN pip3 install --upgrade pip

## Create directry to store extra-addons
## Create odoo user
RUN useradd --system  --home /opt --shell /bin/bash  --uid 1000 odoo && adduser odoo sudo && \
    echo "odoo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    mkdir -p /opt/odoo && mkdir -p /opt/filestore

RUN mkdir /opt/odoo/extra-addons


## Add .ssh key
RUN mkdir /opt/.ssh
COPY .env /opt/.env
COPY start_odoo /opt/odoo/bin/start_odoo
RUN chmod +x /opt/odoo/bin/start_odoo
RUN touch /opt/.ssh/known_hosts

RUN ssh-keyscan bitbucket.org >> /opt/.ssh/known_hosts
RUN ssh-keyscan github.com >> /opt/.ssh/known_hosts
COPY ./odoo.conf /opt/odoo/etc/odoo.conf
COPY ./setup.sh /opt/setup.sh
RUN ["chmod", "+x", "/opt/setup.sh"]


# clone odoo
RUN chown -R odoo  /opt/
user odoo
RUN git clone https://github.com/odoo/odoo.git --depth 1 --branch 15.0 /opt/odoo/odoo
## install requirements from odoo with pip
RUN pip3 install -r /opt/odoo/odoo/requirements.txt
## install extra requirements with pip
COPY requirements.txt /opt/odoo/odoo/requirements-extra.txt
RUN pip3 install -r /opt/odoo/odoo/requirements-extra.txt
## update addons_path and other variables


#RUN chown -R odoo  /opt/
## named mounted VOLUME change permissions so Odoo can create directries
RUN sudo chown -R odoo  /opt/filestore
user odoo

#RUN cp -r /root/.ssh /opt/.ssh
#RUN cp -r /root/.ssh/known_hosts /opt/.ssh/known_hosts
shell ["/bin/bash", "-c"]

RUN /bin/bash -c "/opt/setup.sh"
EXPOSE 15072 15073

WORKDIR /opt/odoo
#ENTRYPOINT ["./odoo-bin", "-c", "/opt/odoo/etc/odoo.conf"]
ENTRYPOINT ["/opt/odoo/bin/start_odoo"]
#ENTRYPOINT ["tail"]
#CMD ["-f","/dev/null"]

