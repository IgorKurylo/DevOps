package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strings"
)

func handler(w http.ResponseWriter, r *http.Request) {
	log.Printf("%s",formatRequest(r))
	buildRequest(w,"Hello World!!!")
}
func health(w http.ResponseWriter, r *http.Request){
	log.Printf("%s",formatRequest(r))
	buildRequest(w,"Status OK")
}
func buildRequest(w http.ResponseWriter,message string){
	w.WriteHeader(http.StatusOK)
	w.Header().Set("Content-Type", "application/json")
	response := make(map[string]string)
	response["message"]=message
	jsonResp, err := json.Marshal(response)
	if err != nil {
		log.Fatalf("error happened in json marshal. Err: %s", err)
	}
	w.Write(jsonResp)
}
func formatRequest(r *http.Request) string{
	var requestOutput []string
	url:=fmt.Sprintf("%v %v %v",r.Method,r.URL,r.Proto)
	requestOutput=append(requestOutput,url)
	requestOutput=append(requestOutput,fmt.Sprintf("Host: %v",r.Host))
	return strings.Join(requestOutput,"\n")

}
func main() {
	http.HandleFunc("/", handler)
	http.HandleFunc("/health",health)
	fmt.Println("Server running...")
	http.ListenAndServe(":8080", nil)
}