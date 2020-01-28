FROM openjdk:8-jdk

# Install Node.js and npm
RUN apt-get update
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs npm maven

# Install app dependencies
RUN mkdir /src
RUN mkdir /src/logs
RUN touch /src/logs/application.log
WORKDIR /src
COPY . /src
RUN rm -rf /src/node_modules
RUN npm install
COPY kcl-bootstrap node_modules/aws-kcl/bin/kcl-bootstrap

RUN mvn install

# Must rename this file so it is loaded first in the classpath.  We override an amazon class.
RUN mv target/kinesis-client-sts-1.0-SNAPSHOT.jar target/a-kinesis-client-sts-1.0-SNAPSHOT.jar

CMD node_modules/aws-kcl/bin/kcl-bootstrap --java /usr/bin/java -c /src/target -e -p properties/kcl.properties