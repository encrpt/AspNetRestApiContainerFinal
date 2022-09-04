# vscode - dotnet

some changes to original repository for testing a dotnetcore restapi example in vscode

additional required enchangements:

- add volumes for data and logs
- update dotnetcore to v6 lts

## prepare environment

- https://dotnet.microsoft.com/en-us/download
- VS-Code extensions

## dotnet cli

```bash
# set language to english
setx DOTNET_CLI_UI_LANGUAGE en

# restore packages
dotnet restore
dotnet list package

# certs
dotnet dev-certs https -ep %USERPROFILE%\.aspnet\https\aspnetapp.pfx -p password
dotnet dev-certs https --trust

# build, run
dotnet run --project ./AspNetRestApiContainer/AspNetRestApiContainer.WebApi -v n
dotnet build AspNetRestApiContainer.sln

```

## docker

```bash
# appsettings.json DefaultConnection strings
# SQL Express
# "DefaultConnection": "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=AspNetRestApiContainerDb;Integrated Security=True;MultipleActiveResultSets=True",
# SQL as docker service, code in Visaul Studio (dev folder)
# "DefaultConnection": "Server=localhost;Initial Catalog=AspNetRestApiContainerDb;User Id=sa;Password=SwN12345678;"
# all services in docker
# "DefaultConnection": "Server=db;Initial Catalog=AspNetRestApiContainerDb;User Id=sa;Password=SwN12345678;"

# in project root
docker-compose up --force-recreate --build -d

# in ./dev - sql server only, change Server=localhost in app appsettings.json - see above
cd ./dev
docker-compose up -f docker-compose.dev.yml

# copy files t an running conatiner
docker cp [filename] [containerid]:[absolute_path]

```

## docker basics

taken from https://docs.microsoft.com/en-us/dotnet/core/docker/build-container

```bash
dotnet publish -c Release
docker build -t counter-image -f Dockerfile .
# create
docker create --name core-counter counter-image
# run + attach
docker start core-counter
docker attach --sig-proxy=false core-counter # --sig-proxy=false - ^C will not stop Process inside container
# or create + run
docker run -it --rm counter-image #  [-it] ^C stops process, [--rm] remove after finished
# change entrypoint
docker run -it --rm --entrypoint "bash" counter-image
```

## fyi only and totally optional

- dotnet formatter

```bash
dotnet tool install -g dotnet-format
# set in vs-code
# "omnisharp.enableRoslynAnalyzers": true,
# "omnisharp.enableEditorConfigSupport": true

```
