# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build
WORKDIR /src

COPY SimpleTimeService.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish SimpleTimeService.csproj -c Release -o /app/publish --no-restore --runtime linux-x64

# Runtime Stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine

RUN apk add --no-cache tzdata && \
    adduser -D -u 1000 myuser

WORKDIR /app
COPY --from=build /app/publish .

# Use non-root user for security
USER myuser

# Expose application port
EXPOSE 5000

# Set environment variable for Kestrel to listen on all interfaces
ENV ASPNETCORE_URLS=http://0.0.0.0:5000

ENTRYPOINT ["dotnet", "SimpleTimeService.dll"]