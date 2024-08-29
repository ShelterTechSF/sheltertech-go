package common

import (
	"encoding/json"
	"log"
	"net/http"
)

type Error struct {
	Error      string `json:"error"`
	StatusCode int    `json:"status_code"`
}

var InternalServerErrorMessage = "Internal Server Error"

func WriteErrorJson(w http.ResponseWriter, statusCode int, errorMsg string) {
	object := Error{
		Error:      errorMsg,
		StatusCode: statusCode,
	}
	output, err := json.Marshal(object)
	if err != nil {
		log.Println("error:", err)
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(statusCode)
	_, err = w.Write(output)
	if err != nil {
		panic(err)
	}
}
