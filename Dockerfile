# Stage 1 - build
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# copy project file and restore
COPY ["JuhwanSeo_Lab4_KubeApi.csproj", "./"]
RUN dotnet restore "JuhwanSeo_Lab4_KubeApi.csproj"

# copy everything and build
COPY . .
RUN dotnet publish "JuhwanSeo_Lab4_KubeApi.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Stage 2 - runtime
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# expose port 8080 inside the container
EXPOSE 8080

# start the app
ENTRYPOINT ["dotnet", "JuhwanSeo_Lab4_KubeApi.dll"]
