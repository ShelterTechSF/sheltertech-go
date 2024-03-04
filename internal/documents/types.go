package documents

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Document struct {
	Id int `json:"id"`
}

func FromDocumentDBType(dbDocument *db.Document) *Document {
	document := &Document{
		Id: dbDocument.Id,
	}
	return document
}

func FromDocumentDBTypeArray(dbDocuments []*db.Document) []*Document {
	documents := []*Document{}
	for _, dbDocument := range dbDocuments {
		documents = append(documents, FromDocumentDBType(dbDocument))
	}
	return documents
}
