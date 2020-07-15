FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS base 
WORKDIR /app 
 
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build 
WORKDIR /src 
COPY ["*.csproj", "./"] 
RUN dotnet restore 
COPY . ./ 
WORKDIR /src 
RUN dotnet build  -c Release -o /app 
 
FROM build AS publish 
RUN dotnet publish -c Release -o /app 
 
FROM base AS final 
WORKDIR /app 
COPY --from=publish /app . 
ENTRYPOINT ["dotnet", "DAF-Web.dll"]