package main

import (
	"encoding/json"
	"fmt"
	"log"
	"os"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/brianloveswords/airtable"
)

// ShopRecord record for a shop
type ShopRecord struct {
	airtable.Record // provides ID, CreatedTime
	Fields          struct {
		Name      string   `json:"name"`
		Image     string   `json:"image_url"`
		Address1  string   `json:"location_display_address_001"`
		Address2  string   `json:"location_display_address_002"`
		Address3  string   `json:"location_display_address_003,omitempty"`
		Phone     string   `json:"display_phone"`
		Latitude  string   `json:"coordinates_latitude"`
		Longitude string   `json:"coordinates_longitude"`
		Flavors   []string `json:"flavors"`
	}
}

func handler(request events.APIGatewayProxyRequest) (*events.APIGatewayProxyResponse, error) {

	client := airtable.Client{
		APIKey: os.Getenv("APIKey"),
		BaseID: os.Getenv("BaseID"),
	}

	shops := client.Table("Seattle Shops")
	listPtr := []ShopRecord{}

	shops.List(&listPtr, &airtable.Options{})

	shopsJSON, err := json.Marshal(listPtr)
	if err != nil {
		log.Fatal("Cannot encode to JSON ", err)
	}

	fmt.Println("Ice Cream Shops:")
	fmt.Println(string(shopsJSON))

	return &events.APIGatewayProxyResponse{
		StatusCode: 200,
		Body:       string(shopsJSON),
	}, nil
}

func main() {
	// Make the handler available for Remote Procedure Call by AWS Lambda
	lambda.Start(handler)
}
