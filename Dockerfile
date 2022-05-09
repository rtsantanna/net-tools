FROM alpine:latest
LABEL maintainer="Sant'Anna, Ricardo <rtsantanna@gmail.com>"

WORKDIR /

# Installing some net tools
RUN apk add --update && apk add --upgrade 
RUN apk add --no-cache bash
RUN apk add --no-cache bc
RUN apk add --no-cache links
RUN apk add --no-cache lynx
RUN apk add --no-cache w3m
RUN apk add --no-cache axel
RUN apk add --no-cache wget
RUN apk add --no-cache aria2
RUN apk add --no-cache mtr
RUN apk add --no-cache htop
RUN apk add --no-cache iputils
RUN apk add --no-cache fping
RUN apk add --no-cache tcptraceroute
RUN apk add --no-cache netcat-openbsd
RUN apk add --no-cache curl
RUN apk add --no-cache tcpdump
RUN apk add --no-cache nmap
RUN apk add --no-cache iperf
RUN apk add --no-cache openssh-client
RUN apk add --no-cache postgresql-client
RUN apk add --no-cache mysql-client
RUN apk add --no-cache aws-cli
RUN apk add busybox-extras
RUN apk add --no-cache alpine-sdk libffi libffi-dev openssl openssl-dev

RUN wget http://www.vdberg.org/~richard/tcpping -O /usr/bin/tcpping
RUN chmod 755 /usr/bin/tcpping

ENV PYTHONUNBUFFERED=1

RUN apk add --no-cache python3
RUN apk add --no-cache gcc musl-dev python3-dev libffi-dev openssl-dev cargo make

RUN ln -sf /usr/bin/python3 /usr/bin/python
RUN ln -sf /usr/bin/pip3 /usr/bin/pip
RUN python3 -m ensurepip
RUN apk add py3-pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python get-pip.py && rm -f get-pip.py
RUN pip3 install --no-cache --upgrade pip
RUN pip3 install azure-cli 

RUN apk add --no-cache glances
RUN apk add --no-cache bind-tools

RUN pip3 install okcli

COPY requirements-oci.txt /
RUN apk add --update alpine-sdk libffi libffi-dev openssl openssl-dev
RUN pip install --no-cache-dir -r requirements-oci.txt
RUN rm -f requirements-oci.txt

# Add static dig binary
ADD paping /usr/local/bin/paping
ADD getmyip-pub.sh /usr/local/bin/
ADD ping_list.sh /usr/local/bin/ 
ADD range.sh /usr/local/bin/
ADD telnet_port.sh /usr/local/bin/
ADD testa_portas.sh /usr/local/bin/

RUN chmod 755 /usr/local/bin/getmyip-pub.sh \
              /usr/local/bin/ping_list.sh \
              /usr/local/bin/range.sh \
              /usr/local/bin/telnet_port.sh \
              /usr/local/bin/testa_portas.sh

RUN rm -rf /var/cache/apk/* /usr/lib/python*/ensurepip

CMD ["sleep", "infinity"]
