package db

import (
	"database/sql"
	"fmt"
	"log"
	"time"
)

type Document struct {
	Id          int
	Name        sql.NullString
	Url         sql.NullString
	Description sql.NullString
	CreatedAt   time.Time
	UpdatedAt   time.Time
}

const documentsByServiceIDSql = `
SELECT d.id, d.name, d.url, d.description
FROM public.documents d
LEFT JOIN public.documents_services ds on d.id = ds.document_id
WHERE ds.service_id = $1
`

func (m *Manager) GetDocumentsByServiceID(serviceId int) []*Document {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(documentsByServiceIDSql, serviceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanDocuments(rows)
}

func scanDocuments(rows *sql.Rows) []*Document {
	var documents []*Document
	for rows.Next() {
		var document Document
		err := rows.Scan(&document.Id, &document.Name, &document.Url, &document.Description)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		documents = append(documents, &document)
	}
	return documents
}
