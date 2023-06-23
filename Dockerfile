# Start by building the application.
FROM golang:1.21-rc as build

WORKDIR /go/src/app
COPY . .

RUN go version
RUN go mod download
RUN touch .env && make test

RUN CGO_ENABLED=0 go build -trimpath -o /go/bin/app

# Now copy it into our base image.
FROM gcr.io/distroless/static
COPY --from=build /go/bin/app /
CMD ["/app"]
