package documents

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Document struct {
	Id          int     `json:"id"`
	Url         *string `json:"url"`
	Name        *string `json:"name"`
	Description *string `json:"description"`
}

func FromDocumentDBType(dbDocument *db.Document) *Document {
	document := &Document{
		Id: dbDocument.Id,
	}
	if dbDocument.Name.Valid {
		document.Name = &dbDocument.Name.String
	}
	if dbDocument.Url.Valid {
		document.Url = &dbDocument.Url.String
	}
	if dbDocument.Description.Valid {
		document.Description = &dbDocument.Description.String
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
