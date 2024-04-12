FROM python:3.11

WORKDIR /app

# copying token. the name used when building the actual image may be different
COPY token token
# Running git clone inside an image is a bad idea and we should use a shell script as a wrapper,
# but we can't do that since we have an internal system which builds the images directly by running
# `docker build . -t <image_name>:<version>`
# What could go wrong anyways
RUN git clone https://pat:$(cat token)@gitlab.com/sl0wc0der/top_secret_repo.git
# removing secrets from the final image since it's sensitive information
RUN rm token

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

CMD ["/bin/bash"]
