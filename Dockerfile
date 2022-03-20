FROM golang:1.17-alpine

WORKDIR /app
COPY . /app

RUN go build -o /sheltertech-go ./cmd/sheltertech-go

EXPOSE 3001

CMD [ "/sheltertech-go" ]