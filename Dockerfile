# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Update package list and install required dependencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        wget \
        ca-certificates \
        software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Install .NET SDK
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
        dotnet-sdk-8.0 \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f packages-microsoft-prod.deb

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Build the application
RUN dotnet build -c Release -o out

# Expose port 5084
EXPOSE 5084

# Set the entry point for the container
ENTRYPOINT ["dotnet", "/app/out/MyWebApp.dll"]

