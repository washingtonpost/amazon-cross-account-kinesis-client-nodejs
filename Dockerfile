FROM    openjdk:8-jdk

# Install Node.js and npm
RUN apt-get update
RUN apt-get install -y curl nodejs npm maven
RUN npm install -g n
RUN n latest
RUN ln -s "$(which nodejs)" /usr/bin/node

# Install app dependencies
RUN mkdir /src
WORKDIR /src
COPY . /src
RUN rm -rf /src/node_modules
RUN npm install

RUN mvn install

CMD node_modules/aws-kcl/bin/kcl-bootstrap --java /usr/bin/java -c /src/target -e -p properties/kcl.properties