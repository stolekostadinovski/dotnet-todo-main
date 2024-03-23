FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the project file and restore dependencies
COPY src/TodoApi.csproj .
RUN dotnet restore

# Copy the entire source code and build the project
COPY src/ .
RUN dotnet build --configuration Release --no-restore

# Publish the project to generate output files
RUN dotnet publish --configuration Release --output /app/out --no-restore

# Use a separate stage for the runtime
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime
WORKDIR /app

# Copy the built output from the build stage to the runtime stage
COPY --from=build /app/out .

# Set the entry point for the application
ENTRYPOINT ["dotnet", "TodoApi.dll"]
