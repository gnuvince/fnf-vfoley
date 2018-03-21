FROM gcc AS build
COPY hello.c /src/
WORKDIR /src/
RUN gcc -O -o hello hello.c
ENTRYPOINT /src/hello


# FROM debian:9.3-slim
# COPY --from=build /src/hello /hello
# ENTRYPOINT /hello
