FROM	python:3

# Install system packages

RUN	set -x \
	&&	apt-get update \
	&&	apt-get install -y --no-install-recommends \
			tree \
			zsh \
	&&	rm -rf /var/lib/apt/lists/*

RUN	pip install --upgrade pip

COPY	requirements.txt /requirements.txt

RUN	pip install -r /requirements.txt

# Provision my user.

RUN	useradd -m -s /bin/zsh maiko

VOLUME	/home/maiko

USER	maiko

WORKDIR	/home/maiko

CMD ["zsh"]
