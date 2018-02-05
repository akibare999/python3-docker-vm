FROM	python:3

ENV	WEB_PORT	8000

# Install system packages

RUN	set -x \
	&&	apt-get update \
	&&	apt-get install -y --no-install-recommends \
			apt-transport-https \
			ca-certificates \
			software-properties-common \
			python-software-properties \
			tree \
			vim \
			zsh \
	&&	rm -rf /var/lib/apt/lists/*


# Install confluent kafka libraries
RUN	wget -qO - https://packages.confluent.io/deb/4.0/archive.key | apt-key add -
RUN	add-apt-repository "deb [arch=amd64] https://packages.confluent.io/deb/4.0 stable main"
RUN	apt-get update && apt-get install -y confluent-platform-oss-2.11
RUN	apt-get update && apt-get install -y librdkafka-dev


# Install pip packages
RUN	pip install --upgrade pip

COPY	requirements.txt /requirements.txt

RUN	pip install -r /requirements.txt

# Expose web port to outside; must publish at runtime
EXPOSE	${WEB_PORT}

# Provision my user.

RUN	useradd -u 9999 -m -s /bin/zsh maiko

VOLUME	/home/maiko

USER	maiko
ENV	BOT_ID		'U3URB1YN9'
ENV	SLACK_BOT_TOKEN	'xoxb-130861066757-NSL9gORaseaZyN1R8Au2Y31W'

WORKDIR	/home/maiko

CMD ["zsh"]
