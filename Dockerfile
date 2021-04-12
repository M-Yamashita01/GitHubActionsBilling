# To enable ssh & remote debugging on app service change the base image to the one below
FROM mcr.microsoft.com/azure-functions/dotnet:3.0-appservice
ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true

RUN apt update && \
    apt install -y \
    ruby \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/site/wwwroot

RUN gem install bundler --no-doc

COPY Gemfile /home/site/wwwroot/
RUN bundler install
COPY . /home/site/wwwroot/