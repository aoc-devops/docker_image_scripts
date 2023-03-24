# Base Image will be as below
FROM ubuntu:20.04
ARG SDLC_ARG
ENV SDLC_ENV=${SDLC_ARG}
RUN echo "ARG value for SDLC_ARG is $SDLC_ARG"
RUN echo "ENV value for SDLC_ENV is $SDLC_ENV"
# To Set a default value
# ARG SDLC_ENV=test
ENV DEBIAN_FRONTEND=noninteractive
# Install dependencies
RUN apt-get update
RUN apt-get install -y apache2
RUN apt-get install -y apache2-utils
# Replace content of Apache Home Page
RUN echo "Docker Image created using Dockerfile for $SDLC_ENV" > /var/www/html/index.html
# Expose Container Port
EXPOSE 80
# Execute command at container launch
CMD ["apache2ctl", "-D", "FOREGROUND"]
