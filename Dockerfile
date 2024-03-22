FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app
COPY src/TodoApi.csproj .
RUN dotnet restore
COPY src/ .
RUN dotnet build --configuration Release --no-restore
RUN dotnet publish --configuration Release --output out --no-restore
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "TodoApi.dll"]
