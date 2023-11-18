# Use the official .NET 8.0 SDK as a base image for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory to /app
WORKDIR /app

# Copy the project files to the container
COPY . .

# Build the application
RUN dotnet publish -c Release -o out

# Use the official ASP.NET Core runtime as a base image for the runtime environment
FROM mcr.microsoft.com/dotnet/aspnet:8.0

# Set the working directory to /app
WORKDIR /app

# Copy the published output from the build image
COPY --from=build /app/out .

# Expose port 5084
EXPOSE 5084

# Define the entry point for the application
ENTRYPOINT ["dotnet", "MyWebApp.dll"]

