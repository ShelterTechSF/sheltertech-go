FROM golang:1.22

WORKDIR /app
COPY . /app

RUN go build -o /sheltertech-go ./cmd/sheltertech-go

EXPOSE 3001

CMD [ "/sheltertech-go" ]