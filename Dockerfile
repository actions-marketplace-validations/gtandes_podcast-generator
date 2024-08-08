FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    python3-venv \
    git

# Create a virtual environment
RUN python3 -m venv /opt/venv

# Activate the virtual environment and install PyYAML
RUN . /opt/venv/bin/activate && pip install PyYAML

COPY feed.py /usr/bin/feed.py
COPY entrypoint.sh /entrypoint.sh

# Modify entrypoint.sh to activate the virtual environment
RUN sed -i '1i\. /opt/venv/bin/activate' /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]