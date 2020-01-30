FROM openjdk:8-jdk

# Install Node.js and npm
RUN apt-get update
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs npm

# Install app dependencies
RUN mkdir /src
RUN mkdir /src/logs
RUN touch /src/logs/application.log
WORKDIR /src
COPY . /src
RUN ls
RUN npm install
COPY patch/kcl-bootstrap node_modules/aws-kcl/bin/kcl-bootstrap

CMD node_modules/aws-kcl/bin/kcl-bootstrap -e -p properties/kcl.properties