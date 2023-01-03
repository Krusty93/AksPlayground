FROM mcr.microsoft.com/dotnet/sdk:6.0 as build

COPY ./src ./src/

RUN dotnet publish \
    -c Release \
    --self-contained false \
    -r linux-x64 \
    -o /app/publish \
    src/AksPlayground.Web/AksPlayground.Web.csproj

FROM mcr.microsoft.com/dotnet/aspnet:6.0 as final
WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 80

ENTRYPOINT [ "dotnet", "AksPlayground.Web.dll" ]