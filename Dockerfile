FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

# Copy and restore project
COPY src/*.csproj ./app/
RUN dotnet restore ./app/app.csproj

# Copy the application source code
COPY src/ ./app/

# Build the application
RUN dotnet publish ./app/app.csproj -c Release -o out

# Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "app.dll"]
